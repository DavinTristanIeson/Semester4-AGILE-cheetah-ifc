<script setup lang="ts">
import { onMounted } from 'vue';
import { useCurrentOrdersStore } from '../../store';
import { useMenuStore } from '@/helpers/menuStore';
import OrderView from "./OrderView.vue";
import WaitView from "./WaitView.vue";
import FetchWrapper from '@/components/function/FetchWrapper.vue';


const menu = useMenuStore();
const currentOrders = useCurrentOrdersStore();
onMounted(async ()=>{
    await currentOrders.initialize();
});
</script>

<template>
    <FetchWrapper :fn="currentOrders.initialize" floating>
        <FetchWrapper :fn="menu.initialize" floating>
            <WaitView v-if="currentOrders.current"/>
            <OrderView v-else/>
        </FetchWrapper>
    </FetchWrapper>
</template>