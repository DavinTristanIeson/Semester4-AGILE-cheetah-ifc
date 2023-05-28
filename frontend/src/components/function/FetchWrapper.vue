<script setup lang="ts">
import { IntervalExecutor } from '@/helpers/requests';
import { reactive, type InjectionKey, provide, inject, onBeforeUnmount, ref } from 'vue';
import { CONNECTION_ERROR } from '@/helpers/constants';
import { PAGE_STATE_KEY, FETCH_KEY } from "../../helpers/keys";

const pageState = inject(PAGE_STATE_KEY);
const props = defineProps<{
    fn: () => Promise<unknown>;
    injectKey?: InjectionKey<unknown>;
    retryInterval?: number;
    alwaysShow?: boolean;
}>();
const emit = defineEmits<{
    (e: "success", data: unknown): void;
    (e: "failure", err: unknown): void;
}>();

const state = reactive({
    show: !!props.alwaysShow,
});
const data = ref(null as any);

const executor = new IntervalExecutor(props.fn, props.retryInterval)
    .on("success", (response) => {
        state.show = true;
        pageState?.clear();
        emit("success", response);
        data.value = response;
    }).on("failure", (e) => {
        let error;
        if (e instanceof Error) error = e.message;
        else error = CONNECTION_ERROR;
        pageState?.setError(error, null);
        emit("failure", e);
    });
executor.run();

provide(props.injectKey || FETCH_KEY, data);

onBeforeUnmount(()=>{
    executor.cleanup();
});
</script>

<template>
    <slot v-if="state.show"></slot>
</template>