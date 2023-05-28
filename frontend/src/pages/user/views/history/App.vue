<script setup lang="ts">
import View from './View.vue';
import Pagination from '@/components/function/Pagination.vue';
import { MenuTransaction } from '@/helpers/classes';
import { TRANSACTION_HISTORY_KEY } from '@/helpers/keys';
import { API } from '@/helpers/constants';

async function fetchHistory(page: number) {
    const params = new URLSearchParams();
    params.append("page", page.toString());
    // fetch dari backend
    const res = await fetch(`${API}/orders/history?${params.toString()}`, {
        credentials: "include"
    });
    if (!res.ok) throw res;
    const json = await res.json();
    return {
        pages: json.pages,
        data: MenuTransaction.fromJSONArray(json.data),
    }
}
</script>

<template>
    <Pagination :fn="fetchHistory" :injectKey="TRANSACTION_HISTORY_KEY">
        <View />
    </Pagination>
</template>