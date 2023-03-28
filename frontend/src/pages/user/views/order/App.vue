<script setup lang="ts">
import { CONNECTION_ERROR } from '@/helpers/constants';
import { IntervalExecutor } from '@/helpers/requests';
import { onBeforeUnmount, onMounted, onUnmounted, reactive } from 'vue';
import { useMenuStore } from '../../store';
import OrderView from "./OrderView.vue";
import WaitView from "./WaitView.vue";

const emit = defineEmits<{
    (e:"loading", value:boolean): void,
    (e:"error", value:string): void,
    (e:"success", value:string): void,
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
    emit("error", "");
}).on("failure", (e)=>{
    console.error(e);
    emit("error", CONNECTION_ERROR);
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