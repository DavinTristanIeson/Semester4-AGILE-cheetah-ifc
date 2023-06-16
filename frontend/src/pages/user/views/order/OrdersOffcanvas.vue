<script setup lang="ts">
import { computed, inject, onBeforeUnmount, onMounted, reactive } from 'vue';
import OrderItem from './components/OrderItem.vue';
import { SERVER_ERROR } from '@/helpers/constants';
import { CURRENT_ORDERS_KEY, PAGE_STATE_KEY } from '@/helpers/keys';

const state = reactive({
    isOffcanvasOpen: true
});
function setOffcanvas(){
    state.isOffcanvasOpen = !window.matchMedia("(max-width: 1200px)").matches;
}
onMounted(()=>{ setOffcanvas(); window.addEventListener("resize", setOffcanvas); });
onBeforeUnmount(()=>{ window.removeEventListener("resize", setOffcanvas) });

const current = inject(CURRENT_ORDERS_KEY)!;
const pageState = inject(PAGE_STATE_KEY)!;
async function sendOrder(){
    if (!current) return;

    pageState.run(async () => {
        if (current.orders.length == 0){
            throw new Error("Minimal harus ada satu pesanan!")
        }
        await current.createTransaction();
        if (!current.orders){
            throw new Error(SERVER_ERROR);
        }
    });
}
const rupiahFmt = Intl.NumberFormat(undefined, {currency: "IDR"});
const hargaTotal = computed(() => {
    const price = current.orders.reduce((acc, cur) => acc + (cur.price * cur.quantity), 0);
    return rupiahFmt.format(price);
});
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
                    <OrderItem v-for="item in current!.orders" :item="item" :key="item.id"/>
                </TransitionGroup>
            </div>
            <div class="position-absolute bottom-0 w-100 mt-2 p-2 border-top tss-bg-secondary">
                <p><b>Total: </b> {{ hargaTotal }}</p>
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