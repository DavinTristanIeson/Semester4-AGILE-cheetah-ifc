<script setup lang="ts">
import { computed } from 'vue';
import { useTransactionsStore } from '../../store';

const transactions = useTransactionsStore();
function changePage(e:Event){
    if (e instanceof KeyboardEvent && e.key != "Enter"){
        return;
    }
    const target = e.target as HTMLInputElement;
    const newPage = parseInt(target.value);
    transactions.changePage(isNaN(newPage) ? 0 : newPage-1);
}
const hasNextPage = computed(()=>transactions.page < transactions.totalPages);
const hasPrevPage = computed(()=>transactions.page > 0);
function incrementPage(inc:number){
    transactions.page = Math.max(0, Math.min(transactions.totalPages, transactions.page + inc));
}
</script>

<template>
    <div class="mb-3">
        <button
            v-if="hasPrevPage"
            class="btn btn-secondary"
            @click="incrementPage(-1)">
            Prev
        </button>
        <input
            class="col-1 mx-2 p-2 border-0 rounded"
            type="number"
            title="Page Number"
            min="1"
            @keypress="changePage"
            @focusout="changePage"
            :value="transactions.page+1"
            :max="transactions.totalPages"
        />
        <button
            v-if="hasNextPage"
            class="btn btn-secondary"
            @click="incrementPage(1)"
        >
            Next
        </button>
    </div>
</template>

<style scoped>
</style>