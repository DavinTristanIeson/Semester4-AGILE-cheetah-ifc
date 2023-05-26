<script setup lang="ts">
import type { MenuOrder } from '@/helpers/classes';

defineProps<{
    item: MenuOrder
}>();
</script>

<template>
    <li class="list-group-item d-flex justify-content-between
        tss-bg-secondary my-1 sleek-shadow">
        <div class="text-start">
            <b>{{ item.name }}</b>
            <div class="text-muted">{{ item.note }}</div>
        </div>
        <div>{{ item.harga }} x{{ item.quantity }}</div>
    </li>
</template>