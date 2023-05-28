<script setup lang="ts">
import View from './View.vue';
import Pagination from '@/components/function/Pagination.vue';
import { MenuTransaction, TransactionSummary } from '@/helpers/classes';
import { API } from '@/helpers/constants';
import { ADMIN_TRANSACTION_HISTORY_KEY } from '@/helpers/keys';

async function fetchHistory(page: number) {
    const params = new URLSearchParams();
    params.append("page", page.toString());
    // fetch dari backend
    const res = await fetch(`${API}/orders/transactions?${params.toString()}`, {
        credentials: "include"
    });
    if (!res.ok) throw res;
    const json = await res.json();
    return {
        pages: json.pages,
        data: TransactionSummary.summarize(MenuTransaction.fromJSONArray(json.data)),
    }
}
</script>

<template>
    <Pagination :fn="fetchHistory" :injectKey="ADMIN_TRANSACTION_HISTORY_KEY">
        <View/>
    </Pagination>
</template>