<script setup lang="ts">
import { PAGINATION_KEY, type PaginationProps } from '@/helpers/keys';
import { PAGE_STATE_KEY } from '@/helpers/keys';
import { inject, provide, type InjectionKey, reactive, computed } from 'vue';
import type FetchWrapperVue from './FetchWrapper.vue';

const props = defineProps<{
    fn: (page: number, params?: any) => Promise<{
        pages: number;
        data: any[];
    }>;
    initialParams?: any,
    injectKey?: InjectionKey<PaginationProps>;
}>();

const pageState = inject(PAGE_STATE_KEY)!;

const state = reactive({
    page: 0,
    totalPages: 0,
    data: [] as any[],
    refetch,
    setPage,
});
async function runFn(page:number, params?: any){
    const res = await pageState.run(async () => {
        const res = await props.fn(page, params);
        state.totalPages = res.pages;
        state.data = res.data;
        return res.data;
    });
    return res;
}
async function refetch(params?: any){
    const res = await runFn(0, params);
    state.page = 0;
    return res;
}
async function setPage(page: number, params?: any){
    const res = await runFn(page, params);
    if (state.page > state.totalPages || state.page < 0) return;
    state.page = page;
    return res;
}




provide(props.injectKey || PAGINATION_KEY, state);

refetch(props.initialParams);
</script>

<template>
    <slot></slot>
</template>