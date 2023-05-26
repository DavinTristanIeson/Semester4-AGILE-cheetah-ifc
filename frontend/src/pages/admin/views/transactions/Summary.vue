<script setup lang="ts">
import OrderListItem from '@/components/display/OrderListItem.vue';
import type { TransactionSummary } from '@/helpers/classes';

defineProps<{
    summary: TransactionSummary
}>();
</script>

<template>
    <div class="col-12 col-sm-6 col-md-4 col-lg-3 mx-2 transaction-summary">
        <div class="tss-bg-primary px-4 py-2 text-center fw-bold fs-3">{{ summary.dateString }}</div>
        <div class="tss-bg-secondary-dark p-3">
            <header class="mb-3">
                <table class="transaction-summary-stats">
                    <tr>
                        <th>Total Pendapatan</th>
                        <td>:</td>
                        <td>{{ summary.hargaTotal }}</td>
                    </tr>
                    <tr>
                        <th>Pendapatan Rata-Rata</th>
                        <td>:</td>
                        <td>{{ summary.hargaRata2 }}</td>
                    </tr>
                    <tr>
                        <th>Jumlah Pesanan</th>
                        <td>:</td>
                        <td>{{ summary.count }}x</td>
                    </tr>
                </table>
            </header>
            <hr/>
            <ul class="list-group transaction-summary-list">
                <OrderListItem :item="order" v-for="order in summary.orders"/>
            </ul>
        </div>
    </div>
</template>