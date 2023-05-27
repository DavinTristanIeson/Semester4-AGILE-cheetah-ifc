<script setup lang="ts">
import { onBeforeUnmount, provide, reactive } from 'vue';
import { PAGE_STATE_KEY } from './keys';
import Spinner from '../display/Spinner.vue';
import Alert from '../display/Alert.vue';

const state = reactive({
    loading: false,
    error: "",
    errorTimeout: -1,
});
function setError(error: string, timeout?: number | null){
    state.error = error;
    if (timeout !== null){
        state.errorTimeout = setTimeout(() => {
            state.error = "";
            state.errorTimeout = -1;
        }, timeout || 3000);
    }
}
function clearError(){
    state.error = '';
    clearTimeout(state.errorTimeout);
    state.errorTimeout = -1;
}
async function run<T>(fn: () => Promise<T>): Promise<T| null> {
    let result: T|null = null;
    state.loading = true;
    try {
        result = await fn();
        clearError();
    } catch (e: any){
        state.loading = false;
        if (e instanceof Error) setError(e.message);
        else setError(e.toString());
    } finally {
        state.loading = false;
    }
    return result;
}
onBeforeUnmount(() => {
    clearTimeout(state.errorTimeout);
});
provide(PAGE_STATE_KEY, {
    loading: state.loading,
    error: state.error,
    setError,
    run,
})
</script>

<template>
    <Spinner :loading="state.loading"/>
    <Alert
        :floating="true"
        :message="state.error"
        @click="clearError"
    />
    <slot></slot>
</template>