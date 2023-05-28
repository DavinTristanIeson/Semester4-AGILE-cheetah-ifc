<script setup lang="ts">
import { computed, inject } from 'vue';
import MenuItemModal from '@/components/display/MenuItemModal.vue';
import { CURRENT_ORDERS_KEY } from '@/helpers/keys';

const currentOrders = inject(CURRENT_ORDERS_KEY)!;
const item = computed(()=>{
    return currentOrders.viewedOrder!;
});
function closeModal(){
    if (item.value.quantity == 0){
        currentOrders.remove(currentOrders.viewedOrder!);
    }
    currentOrders.examine(undefined);
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
    <MenuItemModal :item="item" @close="closeModal">
        <template v-slot:right-bottom>
            <div class="d-flex align-items-center w-100 my-3">
                <button class="btn btn-secondary" @click="changeQuantity(-1)">-</button>
                <span class="mx-2">{{ item.quantity }}</span>
                <button class="btn btn-secondary" @click="changeQuantity(1)">+</button>
            </div>
        </template>
        <template v-slot:bottom>
            <textarea
                rows="3" class="w-100 p-3 rounded"
                :value="item.note" @input="setNote"
                placeholder="Pesan Tambahan"
            ></textarea>
        </template>
    </MenuItemModal>
</template>

<style>
.modal-img {
    max-width: 300px;
}
</style>