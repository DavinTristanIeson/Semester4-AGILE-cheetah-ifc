<script setup lang="ts">
import { IntervalExecutor } from '@/helpers/requests';
import { usePageStateStore, useTransactionsStore } from '../../store';
import Summary from './Summary.vue';
import { CONNECTION_ERROR, SERVER_ERROR } from '@/helpers/constants';
import { onBeforeUnmount } from 'vue';

const transactions = useTransactionsStore();
const pageState = usePageStateStore();

pageState.setLoading(true);
const executor = new IntervalExecutor(transactions.initialize)
    .on("success", () => {
        pageState.cleanup();
        if (!transactions.areTransactionsInitialized){
            pageState.setError(SERVER_ERROR, 3000);
        }
    }).on("failure", (e) => {
        console.error(e);
        pageState.setLoading(false);
        pageState.setError(CONNECTION_ERROR)
    });
executor.run();
onBeforeUnmount(() => {
   executor.cleanup(); 
});
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