<script setup lang="ts">
import { MenuTransaction, MenuOrder, MenuItem } from '@/helpers/classes';
import FinishedOrder from './FinishedOrder.vue';
import { useHistoryStore } from '../../store';
import PageButtons from './PageButtons.vue';
import { IntervalExecutor } from '@/helpers/requests';
import { CONNECTION_ERROR, SERVER_ERROR } from '@/helpers/constants';
import { onBeforeUnmount } from 'vue';

const history = useHistoryStore();
history.initialize();

const emit = defineEmits<{
    (e:"loading", value: boolean): void,
    (e:"error", message:string, timeout:number|null): void
}>();

const executor = new IntervalExecutor(history.initialize)
    .on("success", () => {
        if (history.isHistoryInitialized){
            emit("loading", false);
            emit("error", "", null);
        } else {
            emit("error", SERVER_ERROR, 3000);
        }
    })
    .on("failure", (e) => {
        console.error(e);
        emit("error", CONNECTION_ERROR, null);
    });
executor.run();
onBeforeUnmount(() => executor.cleanup());
</script>

<template>
    <div class="my-4 mx-3">
        <FinishedOrder :order="order" v-for="order in history.current"/>
    </div>
    <PageButtons/>
</template>