<script setup lang="ts">
import { TRANSACTION_HISTORY_KEY } from '@/helpers/keys';
import { inject, watch } from 'vue';
import FinishedOrder from './FinishedOrder.vue';
import PageButtons from '@/components/function/PageButtons.vue';

const history = inject(TRANSACTION_HISTORY_KEY)!;
</script>

<template>
    <div class="my-4 mx-3">
        <FinishedOrder :order="order" v-for="order in history.data"/>
    </div>
    <PageButtons :injectKey="TRANSACTION_HISTORY_KEY"/>
</template>