<script setup lang="ts">
import { CONNECTION_ERROR, SERVER_ERROR } from '@/helpers/constants';
import { IntervalExecutor } from '@/helpers/requests';
import { onBeforeUnmount, onMounted, onUnmounted, provide, reactive } from 'vue';
import { useCurrentOrdersStore, useMenuStore, usePageStateStore } from '../../store';
import OrderView from "./OrderView.vue";
import WaitView from "./WaitView.vue";


const menu = useMenuStore();
const currentOrders = useCurrentOrdersStore();
onMounted(async ()=>{
    await currentOrders.initialize();
});

const pageState = usePageStateStore();
pageState.setLoading(true)
const executor = new IntervalExecutor(menu.initialize)
.on("success", ()=>{
    pageState.cleanup();
    if (!menu.isMenuInitialized){
        pageState.setError(SERVER_ERROR, 3000);
    }
}).on("failure", (e)=>{
    console.error(e);
    pageState.setLoading(false);
    pageState.setError(CONNECTION_ERROR)
});
executor.run();

onBeforeUnmount(()=>{
    executor.cleanup();
});
</script>

<template>
    <WaitView v-if="currentOrders.current"/>
    <OrderView v-else/>
</template>