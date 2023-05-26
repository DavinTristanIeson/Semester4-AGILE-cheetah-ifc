<script setup lang="ts">
import { IntervalExecutor } from '@/helpers/requests';
import { usePageStateStore, useTransactionsStore } from '../../store';
import Summary from './Summary.vue';
import FetchWrapper from '@/components/function/FetchWrapper.vue';
import PageButtons from './PageButtons.vue';

const transactions = useTransactionsStore();
</script>

<template>
    <FetchWrapper floating :fn="transactions.initialize">
        <div class="horizontal-scroll mt-4">
            <Summary :summary="summary" v-for="summary in transactions.transactions"/>
        </div>
        <PageButtons/>
    </FetchWrapper>
</template>

<style>
.horizontal-scroll {
    display: flex;
    overflow-x: auto;
}
</style>