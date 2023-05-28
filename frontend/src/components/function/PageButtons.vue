<script setup lang="ts">
import { computed, inject, type InjectionKey } from 'vue';
import { PAGINATION_KEY, type PaginationProps } from '@/helpers/keys';

const props = defineProps<{
    injectKey?: InjectionKey<PaginationProps>
    params?: any
}>();
const pagination = inject(props.injectKey || PAGINATION_KEY)!;

function clampPage(page: number){
    return  Math.max(0, Math.min(
        pagination.totalPages-1, page
    ));
}
function changePage(e:Event){
    if (e instanceof KeyboardEvent && e.key != "Enter"){
        return;
    }
    const target = e.target as HTMLInputElement;
    const parsedPage = parseInt(target.value);
    const newPage = isNaN(parsedPage) ? 0 : clampPage(parsedPage);
    pagination.setPage(newPage, props.params);
    target.value = (newPage + 1).toString();
}
const hasNextPage = computed(() => pagination.page < pagination.totalPages-1 && pagination.totalPages != 0);
const hasPrevPage = computed(() => pagination.page > 0);
function incrementPage(inc:number){
    pagination.setPage(clampPage(pagination.page + inc), props.params);
}
</script>

<template>
    <div class="mb-3">
        <button
            v-if="hasPrevPage"
            class="btn btn-secondary"
            @click="incrementPage(-1)">
            Prev
        </button>
        <input
            class="col-1 mx-2 p-2 border-0 rounded"
            type="number"
            title="Page Number"
            min="1"
            :max="pagination.totalPages"
            @keypress="changePage"
            @focusout="changePage"
            :value="pagination.page+1"
        />
        <button
            v-if="hasNextPage"
            class="btn btn-secondary"
            @click="incrementPage(1)"
        >
            Next
        </button>
    </div>
</template>