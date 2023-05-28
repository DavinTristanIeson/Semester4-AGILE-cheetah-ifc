<script setup lang="ts">
import { ADMIN_TRANSACTION_HISTORY_KEY } from '@/helpers/keys';
import PageButtons from '@/components/function/PageButtons.vue';
import Summary from './Summary.vue';
import { inject } from 'vue';

const transactions = inject(ADMIN_TRANSACTION_HISTORY_KEY)!;
</script>

<template>
    <div class="horizontal-scroll mt-4 mb-3">
        <Summary :summary="summary" v-for="summary in transactions.data" />
    </div>
    <PageButtons :injectKey="ADMIN_TRANSACTION_HISTORY_KEY"/>
</template>

<style>
.horizontal-scroll {
    display: flex;
    overflow-x: auto;
}
</style>