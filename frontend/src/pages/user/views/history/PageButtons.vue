<script setup lang="ts">
import { computed } from 'vue';
import { useHistoryStore } from '../../store';

const history = useHistoryStore();
function changePage(e:Event){
    if (e instanceof KeyboardEvent && e.key != "Enter"){
        return;
    }
    const target = e.target as HTMLInputElement;
    const newPage = parseInt(target.value);
    history.changePage(isNaN(newPage) ? 0 : newPage-1);
}
const hasNextPage = computed(()=>history.page < history.totalPages);
const hasPrevPage = computed(()=>history.page > 0);
function incrementPage(inc:number){
    history.page = Math.max(0, Math.min(history.totalPages, history.page + inc));
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
            :value="history.page+1"
            :max="history.totalPages"
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