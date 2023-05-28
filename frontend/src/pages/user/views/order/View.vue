<script setup lang="ts">
// Saya kurang suka harus buat begini karena limitasi provide-inject, but oh well
import WaitView from './WaitView.vue';
import OrderView from './OrderView.vue';
import { CURRENT_ORDERS_KEY } from '@/helpers/keys';
import { inject } from 'vue';

const orders = inject(CURRENT_ORDERS_KEY)!;
</script>

<template>
    <WaitView v-if="orders.current" />
    <OrderView v-else />
</template>