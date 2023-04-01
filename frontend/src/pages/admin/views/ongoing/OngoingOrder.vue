<script setup lang="ts">
import Accordion from '@/components/Accordion.vue';
import type { MenuTransaction } from "@/helpers/classes";
import { computed, onBeforeUnmount, onMounted, reactive } from 'vue';
import OrderListItem from '../../../../components/OrderListItem.vue';
import { useOngoingOrdersStore } from '../../store';


const props = defineProps<{
    order: MenuTransaction
}>();
const state = reactive({
    timeDiff: 0,
    intervalID: -1,
});
const orders = useOngoingOrdersStore();
onMounted(()=>{
    state.intervalID = setInterval(()=>{
        state.timeDiff = new Date().getTime() - props.order.time.getTime();
        if (state.timeDiff >= 60*60*1000){
            clearInterval(state.intervalID);
        }
    }, 1*60*1000);
});
onBeforeUnmount(()=>{
    clearInterval(state.intervalID);
});
const accordionClass = computed(()=>{
    if (state.timeDiff >= 60*60*1000) return "flashingred";
    else if (state.timeDiff <= 1*60*1000) return "flashing";
    else return "";
});

function finishOrder(){
    // TODO: hubung dengan backend
    props.order.phase = "finished";
    orders.removeOrder(props.order);
}
</script>
 
<template>
    <Accordion :class="accordionClass">
        <template v-slot:header>
            <span class="badge text-bg-warning me-5" v-if="order.phase == 'pending'">Pending</span>
            <span class="badge text-bg-info me-5" v-if="order.phase == 'cooking'">Cooking</span>
            {{ `${order.timeString} | Pesanan oleh ${order.username}` }}
        </template>
        <ul class="list-group mx-3">
            <OrderListItem :item="item" v-for="item in order.orders"/>
        </ul>
        <div class="my-2 mx-3 w-100"><b>Total: </b> {{ order.hargaTotal }}</div>
        <button class="mx-3 btn btn-warning" v-if="order.phase == 'pending'" @click="order.phase = 'cooking'">Pesanan Sedang Dimasak</button>
        <button class="mx-3 btn btn-info" v-if="order.phase == 'cooking'" @click="finishOrder">Pesanan Selesai</button>
    </Accordion>
</template>

<style>
.flashing {
    animation: flashing 1s linear 0s infinite;
}
.flashingred {
    animation: flashingred 1s linear 0s infinite;
}
@keyframes flashing {
    from {background-color: var(--primary);}
    40% {background-color: var(--secondary-dark);}
    80% { background-color: var(--primary);}
    to { background-color: var(--primary);}
}

@keyframes flashingred {
    from {background-color: var(--primary);}
    40% {background-color: var(--bs-danger-bg-subtle);}
    80% { background-color: var(--primary);}
    to { background-color: var(--primary);}
}
</style>
