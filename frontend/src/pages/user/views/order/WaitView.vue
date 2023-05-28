<script setup lang="ts">
import OrderListItem from '@/components/display/OrderListItem.vue';
import { CURRENT_ORDERS_KEY } from '@/helpers/keys';
import { socket } from '@/helpers/requests';
import { inject, onBeforeUnmount } from 'vue';

const currentOrders = inject(CURRENT_ORDERS_KEY)!;
const state = {
    cancelReason: ""
}

socket.on("cookOrder", (id:number) => {
    if (id != currentOrders.current!.id) return;
    currentOrders.current!.phase = "cooking";
});
socket.on("finishOrder", (id:number) => {
    if (id != currentOrders.current!.id) return;
    currentOrders.current!.phase = "finished";
});
socket.on("cancelOrder", (id: number, reason: string) => {
    if (id != currentOrders.current!.id) return;
    currentOrders.current!.phase = "canceled";
    state.cancelReason = reason;
})
onBeforeUnmount(() => {
    socket.off("cookOrder");
    socket.off("finishOrder");
});
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
        <div class="col-6 d-flex flex-column align-items-center darkened-bg p-3">
            <div class="text-capitalize fs-2 p-3 rounded fw-bold"
            :class="{
                'text-warning': currentOrders.current!.phase == 'pending',
                'text-info': currentOrders.current!.phase == 'cooking',
                'text-success': currentOrders.current!.phase == 'finished',
                'text-danger': currentOrders.current!.phase == 'canceled',
                'fw-bold': currentOrders.current!.phase == 'finished',
            }">{{ currentOrders.current!.phase }}</div>
            <div v-if="currentOrders.current!.phase == 'finished'">
                <a class="text-success fw-bold" href="#" @click.prevent="currentOrders.finishTransaction">
                    Click untuk kembali ke halaman sebelumnya!
                </a>
            </div>
            <div v-if="currentOrders.current!.phase == 'canceled'">
                <p class="text-danger">Pesan anda telah dibatalkan karena:</p>
                <blockquote class="alert alert-danger">
                    {{ state.cancelReason }}
                </blockquote>
                <a class="text-danger fw-bold" href="#" @click.prevent="currentOrders.cancelTransaction">
                    Click untuk kembali ke halaman sebelumnya!
                </a>
            </div>

            <div id="waiting-logo" class="status-logo mt-3" v-if="currentOrders.current!.phase == 'cooking' || currentOrders.current!.phase == 'pending'">
                <img src="@/assets/schedule.svg" alt="Waiting..."/>
            </div>
            <div id="success-logo" class="status-logo mt-3" v-if="currentOrders.current!.phase == 'finished'">
                <img src="@/assets/check.svg" alt="Success"
                @click="currentOrders.finishTransaction"/>
            </div>
            <div id="cancel-logo" class="status-logo mt-3" v-if="currentOrders.current!.phase == 'canceled'">
                <img src="@/assets/cancel.svg" alt="Success"
                @click="currentOrders.cancelTransaction"/>
            </div>
        </div>
    </div>
</template>

<style>
.darkened-bg {
    background-color: rgba(0, 0, 0, 0.4);
    border-radius: 24px;
}
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
#cancel-logo {
    background-color: #ff7777;
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