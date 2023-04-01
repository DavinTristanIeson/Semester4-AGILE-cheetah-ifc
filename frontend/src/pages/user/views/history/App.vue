<script setup lang="ts">
import { MenuTransaction, MenuOrder, MenuItem } from '@/helpers/classes';
import FinishedOrder from './FinishedOrder.vue';
import { useHistoryStore } from '../../store';
import PageButtons from './PageButtons.vue';

const history = useHistoryStore();
history.initialize();

const emit = defineEmits<{
    (e:"loading", value: boolean): void,
    (e:"error", value:string): void
}>();
</script>

<template>
    <div class="my-4 mx-3">
        <FinishedOrder :order="order" v-for="order in history.current"/>
    </div>
    <PageButtons/>
</template>