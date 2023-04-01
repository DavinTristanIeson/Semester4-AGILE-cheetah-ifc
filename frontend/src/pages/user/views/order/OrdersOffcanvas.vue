<script setup lang="ts">
import type { MenuOrder } from '@/helpers/classes';
import { onBeforeUnmount, onMounted, reactive } from 'vue';
import { useCurrentOrdersStore } from '../../store';
import OrderItem from './OrderItem.vue';

const state = reactive({
    isOffcanvasOpen: true
});
function setOffcanvas(){
    state.isOffcanvasOpen = !window.matchMedia("(max-width: 1200px)").matches;
}
onMounted(()=>{ setOffcanvas(); window.addEventListener("resize", setOffcanvas); });
onBeforeUnmount(()=>{ window.removeEventListener("resize", setOffcanvas) });
const currentOrders = useCurrentOrdersStore();
function sendOrder(){
    // TODO: send pesan ke backend
}
</script>

<template>
<button
    class="btn btn-primary d-lg-none open-offcanvas-btn"
    @click="state.isOffcanvasOpen = true"
>
Pesanan Anda    
</button>
    <div class="offcanvas offcanvas-end" :class="{show: state.isOffcanvasOpen, hiding: !state.isOffcanvasOpen}" data-bs-scroll="true"
        data-bs-backdrop="false" tabindex="-1" aria-labelledby="yourOrdersOffcanvasLabel">
        <div class="offcanvas-header border-bottom tss-bg-secondary">
            <h5 class="offcanvas-title" id="yourOrdersOffcanvasLabel">Pesanan Anda</h5>
            <button
                type="button" class="btn-close d-lg-none"
                data-bs-dismiss="offcanvas" aria-label="Close"
                @click="state.isOffcanvasOpen = false"
            ></button>
        </div>
        <div class="offcanvas-body p-0">
            <div class="px-2 py-1">
                <TransitionGroup name="list-slide-left" tag="ul" class="list-group">
                    <OrderItem v-for="item in currentOrders.orders" :item="item" :key="item.id"/>
                </TransitionGroup>
                <!-- TODO: List item yang dipesan -->
            </div>
            <div class="position-absolute bottom-0 w-100 mt-2 p-2 border-top tss-bg-secondary">
                <p><b>Total: </b> {{ currentOrders.hargaTotal }}</p>
                <div class="w-100 text-center">
                    <button class="btn btn-primary w-75" @click="sendOrder">Pesan</button>
                </div>
            </div>
        </div>
    </div>    
</template>

<style>

/* Override untuk style bootstrap */
.offcanvas {
    --bs-offcanvas-width: 400px;
    z-index: 10;
}
.open-offcanvas-btn {
    position: fixed;
    top: 17%;
    right: 5%;
}
</style>