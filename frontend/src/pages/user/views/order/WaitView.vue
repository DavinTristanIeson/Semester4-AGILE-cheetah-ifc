<script setup lang="ts">
import { useCurrentOrdersStore } from '../../store';
import OrderListItem from '@/components/OrderListItem.vue';
import { MenuTransaction } from '@/helpers/classes';
import { socket } from '@/helpers/requests';
import { computed, onBeforeUnmount } from 'vue';
import { useRouter } from 'vue-router';

const currentOrders = useCurrentOrdersStore();
socket.on("cookOrder", (id:number) => {
    if (id != currentOrders.current!.id) return;
    currentOrders.current!.phase = "cooking";
});
socket.on("finishOrder", (id:number) => {
    if (id != currentOrders.current!.id) return;
    currentOrders.current!.phase = "finished";
});
onBeforeUnmount(() => {
    socket.off("cookOrder");
    socket.off("finishOrder");
});

function finishWait(){
    currentOrders.finishTransaction();
}
</script>

<template>
    <div class="d-flex mt-5 mx-2 mx-lg-5">
        <div class="col-6 tss-bg-secondary-dark position-relative rounded">
            <header class="tss-bg-primary px-3 py-2 text-center fs-2 fw-bold rounded">
                Pesanan Anda
            </header>
            <div class="py-4 px-3">
                <ul class="list-group transaction-summary-list">
                    <OrderListItem :item="order" v-for="order in currentOrders.current!.orders"/>
                </ul>
                <hr/>
                <div class="position-absolute bottom-0 mb-3">
                    <b>Total: </b> {{ currentOrders.current!.hargaTotal }}
                </div>
            </div>
        </div>
        <div class="col-6 d-flex flex-column align-items-center">
            <div class="text-capitalize fs-2 p-3 rounded fw-bold shadow-lg"
            :class="{
                'text-warning': currentOrders.current!.phase == 'pending',
                'text-info': currentOrders.current!.phase == 'cooking',
                'text-success': currentOrders.current!.phase == 'finished',
                'fw-bold': currentOrders.current!.phase == 'finished',
            }">{{ currentOrders.current!.phase }}</div>
            <a class="text-success fw-bold" v-if="currentOrders.current!.phase == 'finished'" href="#" @click.prevent="finishWait">Click untuk kembali ke halaman sebelumnya!</a>
            <div id="waiting-logo" class="status-logo mt-3" v-if="currentOrders.current!.phase !== 'finished'">
                <img src="@/assets/schedule.svg" alt="Waiting..."/>
            </div>
            <div id="success-logo" class="status-logo mt-3" v-else>
                <img src="@/assets/check.svg" alt="Success" @click="finishWait"/>
            </div>
        </div>
    </div>
</template>

<style>
.status-logo img {
    width: 200px;
    height: 200px;
}
.status-logo {
    width: fit-content; height: fit-content;
    border-radius: 50%;
    opacity: 0.7;
}
#waiting-logo {
    background-color: rgba(255, 255, 150, 0.9);
    animation: pulse 1.5s ease-out 1s infinite;
}
#success-logo {
    background-color: #77ff77;
    animation: slowpulse 1.5s ease-out 1s infinite;
}
@keyframes slowpulse {
    from {
        padding: 0px;
        transform: translate(0px,0px);
    }
    20% {
        padding: 10px;
        transform: translate(0px,-10px);
    }
    60% {
        padding: 0px;
        transform: translate(0px,0px);
    }
}
@keyframes pulse {
    from {
        padding: 0px;
        transform: translate(0px,0px);
        background-color: rgba(255, 255, 150, 0.9);
    }
    5% {
        padding: 35px;
        transform: translate(0px,-35px);
        background-color: rgba(255, 255, 150, 0.4);
    }
    40% {
        padding: 0px;
        transform: translate(0px,0px);
        background-color: rgba(255, 255, 150, 0.9);
    }
}
</style>