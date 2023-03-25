<script setup lang="ts">
import IconButton from '@/components/IconButton.vue';
import type { MenuOrder } from '@/helpers/classes';
import { useCurrentOrdersStore } from '../../store';
const props = defineProps<{
    item:MenuOrder
}>();
const currentOrders = useCurrentOrdersStore()
function removeOrder(){
    currentOrders.removeOrder(props.item);
}
</script>

<template>
<li class="your-orders list-group-item d-flex justify-content-between align-items-center">
    <div class="w-100 me-4">
        <b>{{ item.name }}</b>
        <div>{{ item.harga }} x{{ item.quantity }}</div>
        <div class="text-muted">{{ item.note }}</div>
    </div>
    <IconButton
        icon="/delete.svg"
        semantic="Delete Order"
        @click="removeOrder"
        class="btn-danger"
    />
</li>
</template>

<style>
</style>