<script setup lang="ts">
import { computed, reactive } from 'vue';
import { useCurrentOrdersStore } from '../../store';

const currentOrders = useCurrentOrdersStore();
const state = reactive({
    showOriginalImage: true,
});
const item = computed(()=>{
    return currentOrders.viewedOrder!;
});

function imageNotAvailable(){
    state.showOriginalImage = false;
}
function closeModal(){
    if (item.value.quantity == 0){
        currentOrders.removeOrder(currentOrders.viewedOrder!);
    }
    currentOrders.examineOrder(undefined);
}
function changeQuantity(inc:number){
    item.value.quantity = Math.max(0, Math.min(9, item.value.quantity + inc));
}
function setNote(e:Event){
    const target = e.target as HTMLTextAreaElement;
    item.value.note = target.value;
}
</script>
<template>
    <div class="modal d-block" tabindex="-1"
        aria-hidden="true" role="dialog">
        <div class="modal-dialog" v-if="currentOrders.viewedOrder">
            <div class="modal-content">
                <div class="modal-header tss-bg-secondary">
                    <h5 class="modal-title">{{ item.name }}</h5>
                    <button class="btn-close" @click="closeModal"></button>
                </div>
                <div class="modal-body">
                    <div class="d-flex mb-3">
                        <img v-if="state.showOriginalImage" :src="item.img" :alt="item.name"
                            class="modal-img" loading="lazy" @error="imageNotAvailable">
                        <img v-else src="@/assets/image-not-available.jpg" :alt="item.name" class="modal-img">
                        <div class="mx-3">
                            <p class="fs-6 mb-2">{{ item.description }}</p>
                            <p class="fs-6 mb-0"><i>{{ item.harga }}</i></p>
                            <div class="d-flex align-items-center w-100 mb-3">
                                <button class="btn btn-secondary" @click="changeQuantity(-1)">-</button>
                                <span class="mx-2">{{ item.quantity }}</span>
                                <button class="btn btn-secondary" @click="changeQuantity(1)">+</button>
                            </div>
                        </div>
                    </div>
                    <textarea
                        rows="3" class="w-100 p-3 rounded"
                        :value="item.note" @input="setNote"
                        placeholder="Pesan Tambahan"
                    ></textarea>
                </div>
            </div>
        </div>
    </div>
</template>

<style>
.modal-img {
    max-width: 300px;
}
</style>