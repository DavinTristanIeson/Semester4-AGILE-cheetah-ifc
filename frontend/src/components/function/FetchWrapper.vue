<script setup lang="ts">
import { IntervalExecutor } from '@/helpers/requests';
import { reactive, type InjectionKey, provide, inject, onBeforeUnmount } from 'vue';
import Spinner from '../display/Spinner.vue';
import Alert from '../display/Alert.vue';
import { CONNECTION_ERROR } from '@/helpers/constants';
import { PAGE_STATE_KEY } from "./keys";

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
    show: !!props.alwaysShow
});

const executor = new IntervalExecutor(props.fn, props.retryInterval)
    .on("success", (response) => {
        state.show = true;
        pageState?.clear();
        emit("success", response);
    }).on("failure", (e) => {
        let error;
        if (e instanceof Error) error = e.message;
        else error = CONNECTION_ERROR;
        pageState?.setError(error, null);
        emit("failure", e);
    });
executor.run();

onBeforeUnmount(()=>{
    executor.cleanup();
});
</script>

<template>
    <slot v-if="state.show"></slot>
</template>