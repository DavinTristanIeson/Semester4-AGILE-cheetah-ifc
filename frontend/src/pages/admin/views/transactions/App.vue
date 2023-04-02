<script setup lang="ts">
import { IntervalExecutor } from '@/helpers/requests';
import { useTransactionsStore } from '../../store';
import Summary from './Summary.vue';
import { CONNECTION_ERROR, SERVER_ERROR } from '@/helpers/constants';
import { onBeforeUnmount } from 'vue';

const emit = defineEmits<{
    (e:"loading", value: boolean): void,
    (e:"error", message:string, timeout:number|null): void
}>();

const transactions = useTransactionsStore();

emit("loading", true);
const executor = new IntervalExecutor(transactions.initialize)
    .on("success", () => {
        if (transactions.areTransactionsInitialized){
            emit("error", "", null);
            emit("loading", false);
        } else {
            emit("error", SERVER_ERROR, 3000);
        }
    }).on("failure", (e) => {
        console.error(e);
        emit("error", CONNECTION_ERROR, null);
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