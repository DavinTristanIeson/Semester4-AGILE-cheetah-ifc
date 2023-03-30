<script setup lang="ts">
import { CONNECTION_ERROR } from '@/helpers/constants';
import { IntervalExecutor } from '@/helpers/requests';
import { onBeforeUnmount, onMounted, onUnmounted, reactive } from 'vue';
import { useMenuStore } from '../../store';
import OrderView from "./OrderView.vue";
import WaitView from "./WaitView.vue";

const emit = defineEmits<{
    (e:"loading", value:boolean): void,
    (e:"error", value:string, timeout:number|null): void,
    (e:"success", value:string, timeout:number|null): void,
}>();


const state = reactive({
    isWaiting: false,
});
const menu = useMenuStore();
emit("loading", true);
const executor = new IntervalExecutor(async ()=>{
    await menu.initialize();
}).on("success", ()=>{
    emit("loading", false);
    emit("error", "", null);
}).on("failure", (e)=>{
    console.error(e);
    emit("error", CONNECTION_ERROR, null);
});
executor.run();

onBeforeUnmount(()=>{
    executor.cleanup();
});
</script>

<template>
    <WaitView v-if="state.isWaiting"/>
    <OrderView v-else/>
</template>