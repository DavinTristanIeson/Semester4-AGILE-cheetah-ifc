<script setup lang="ts">
import { IntervalExecutor } from '@/helpers/requests';
import { reactive, type InjectionKey, provide, onBeforeUnmount } from 'vue';
import Spinner from '../display/Spinner.vue';
import Alert from '../display/Alert.vue';
import { CONNECTION_ERROR, SERVER_ERROR } from '@/helpers/constants';

const props = defineProps<{
    fn: () => Promise<unknown>;
    retryInterval?: number;
    floating?: boolean;
}>();
const emit = defineEmits<{
    (e: "success", data: unknown): void;
    (e: "failure", err: unknown): void;
}>();

const state = reactive({
    loading: true,
    error: "",
});


const executor = new IntervalExecutor(props.fn, props.retryInterval)
    .on("success", (response) => {
        state.loading = false;
        state.error = "";
        emit("success", response);
    }).on("failure", (e) => {
        if (e instanceof Error) state.error = e.message;
        else state.error = CONNECTION_ERROR;
        emit("failure", e);
    });
executor.run();

onBeforeUnmount(()=>{
    executor.cleanup();
});
</script>

<template>
    <div :class="{'position-relative': !floating}" v-if="state.loading || state.error">
        <Spinner floating :loading="state.loading"/>
        <Alert floating :error="state.error"/>
    </div>
    <slot v-else></slot>
</template>