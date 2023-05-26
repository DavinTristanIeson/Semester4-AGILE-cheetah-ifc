<script setup lang="ts">
import FinishedOrder from './FinishedOrder.vue';
import { useHistoryStore, usePageStateStore } from '../../store';
import PageButtons from './PageButtons.vue';
import { IntervalExecutor } from '@/helpers/requests';
import { CONNECTION_ERROR, SERVER_ERROR } from '@/helpers/constants';
import { onBeforeUnmount } from 'vue';

const history = useHistoryStore();
history.initialize();
const pageState = usePageStateStore();

pageState.setLoading(true);
const executor = new IntervalExecutor(history.initialize)
    .on("success", () => {
        pageState.cleanup();
        if (!history.isHistoryInitialized){
            pageState.setError(SERVER_ERROR, 3000);
        }
    })
    .on("failure", (e) => {
        console.error(e);
        pageState.setLoading(false);
        pageState.setError(CONNECTION_ERROR)
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