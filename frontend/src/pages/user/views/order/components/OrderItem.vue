<script setup lang="ts">
import IconButton from '@/components/display/IconButton.vue';
import type { MenuOrder } from '@/helpers/classes';
import { CURRENT_ORDERS_KEY } from '@/helpers/keys';
import { inject } from 'vue';
const props = defineProps<{
    item:MenuOrder
}>();
const currentOrders = inject(CURRENT_ORDERS_KEY)!;
function removeOrder(){
    currentOrders.remove(props.item);
}
function examineOrder(){
    currentOrders.viewedOrder = props.item;
}
</script>

<template>
<li class="your-orders list-group-item d-flex justify-content-between align-items-center"
@click="examineOrder">
    <div class="w-100 me-4">
        <b>{{ item.name }}</b>
        <div>{{ item.harga }} x{{ item.quantity }}</div>
        <div class="text-muted">{{ item.note }}</div>
    </div>
    <IconButton
        icon="/delete.svg"
        semantic="Delete Order"
        @click.stop="removeOrder"
        class="btn-danger"
    />
</li>
</template>

<style>
.your-orders {
    transition: transform 0.2s, background-color 0.2s;
    cursor: pointer;
}
.your-orders:hover {
    transform: translateX(2%);
    background-color: var(--secondary);
}
</style>