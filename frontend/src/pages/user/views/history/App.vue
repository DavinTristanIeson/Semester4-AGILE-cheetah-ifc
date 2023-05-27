<script setup lang="ts">
import FinishedOrder from './FinishedOrder.vue';
import { useHistoryStore } from '../../store';
import PageButtons from './PageButtons.vue';
import FetchWrapper from '@/components/function/FetchWrapper.vue';

const history = useHistoryStore();
</script>

<template>
    <FetchWrapper :fn="history.initialize">
        <div class="my-4 mx-3">
            <FinishedOrder :order="order" v-for="order in history.current"/>
        </div>
        <PageButtons/>
    </FetchWrapper>
</template>