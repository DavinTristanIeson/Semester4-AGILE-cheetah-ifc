<script setup lang="ts">
import { computed } from 'vue';
import { useCurrentOrdersStore } from '../../../store';
import MenuItemModal from '@/components/display/MenuItemModal.vue';

const currentOrders = useCurrentOrdersStore();
const item = computed(()=>{
    return currentOrders.viewedOrder!;
});
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
    <MenuItemModal :item="item" @close="closeModal">
        <template v-slot:side-under>
            <div class="d-flex align-items-center w-100 my-3">
                <button class="btn btn-secondary" @click="changeQuantity(-1)">-</button>
                <span class="mx-2">{{ item.quantity }}</span>
                <button class="btn btn-secondary" @click="changeQuantity(1)">+</button>
            </div>
        </template>
        <template v-slot:under>
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