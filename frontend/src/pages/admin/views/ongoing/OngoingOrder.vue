<script setup lang="ts">
import Accordion from '@/components/display/Accordion.vue';
import { MenuTransaction } from "@/helpers/classes";
import { computed, inject, onBeforeUnmount, onMounted, reactive } from 'vue';
import OrderListItem from '@/components/display/OrderListItem.vue';
import { API, SERVER_ERROR } from '@/helpers/constants';
import { ONGOING_ORDERS_KEY, PAGE_STATE_KEY } from '@/helpers/keys';


const props = defineProps<{
    order: MenuTransaction
}>();
const state = reactive({
    timeDiff: new Date().getTime() - props.order.time.getTime(),
    intervalID: -1,
});
const orders = inject(ONGOING_ORDERS_KEY)!;
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
const pageState = inject(PAGE_STATE_KEY)!;

async function changePhase(){
    pageState.run(async () => {
        if (props.order.phase == "cooking"){
            orders.remove(props.order);
        }
        props.order.phase = MenuTransaction.parseStatus(props.order.toStatus()-1);
        const res = await fetch(`${API}/orders/${props.order.id}/status`, {
            method: "PUT",
            headers: {
                'Content-Type': "application/json",
            },
            credentials: "include",
            body: JSON.stringify({status: props.order.toStatus()})
        });
        if (!res.ok) throw new Error(SERVER_ERROR);
    });
}
async function cancelOrder(){
    const reason = prompt("Apa alasan dari pembatalan pesanan ini?");
    pageState.run(async () => {
        const res = await fetch(`${API}/orders/${props.order.id}`, {
            method: 'DELETE',
            headers: {
                'Content-Type': "application/json",
            },
            credentials: "include",
            body: JSON.stringify({
                reason,
            })
        });
        if (!res.ok) throw new Error(SERVER_ERROR);
        orders.remove(props.order);
    });
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
        <button class="mx-3 btn btn-warning" v-if="order.phase == 'pending'" @click="changePhase">Pesanan Sedang Dimasak</button>
        <button class="mx-3 btn btn-info" v-if="order.phase == 'cooking'" @click="changePhase">Pesanan Selesai</button>
        <button class="mx-3 btn btn-danger" @click="cancelOrder">Batal Pesanan</button>
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
