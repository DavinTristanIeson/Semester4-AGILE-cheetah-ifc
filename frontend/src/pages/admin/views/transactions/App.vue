<script setup lang="ts">
import { useTransactionsStore } from '../../store';
import Summary from './Summary.vue';

const transactions = useTransactionsStore();
transactions.initialize();
</script>

<template>
    <div class="horizontal-scroll mt-4">
        <Summary :summary="summary" v-for="summary in transactions.transactions"/>
    </div>
</template>

<style>
.horizontal-scroll {
    display: flex;
    overflow-x: auto;
}
</style>