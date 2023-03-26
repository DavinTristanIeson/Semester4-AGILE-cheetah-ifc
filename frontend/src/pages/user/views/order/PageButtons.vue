<script setup lang="ts">
import { computed } from 'vue';
import { useMenuStore } from '../../store';

const menu = useMenuStore();
function changePage(e:Event){
    const target = e.target as HTMLInputElement;
    const newPage = parseInt(target.value);
    menu.changePage(isNaN(newPage) ? 0 : newPage-1);
}
const hasNextPage = computed(()=>menu.page < menu.totalPages-1);
const hasPrevPage = computed(()=>menu.page > 0);
function incrementPage(inc:number){
    menu.page = Math.max(0, Math.min(menu.totalPages, menu.page + inc));
}
</script>

<template>
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
        @focusout="changePage"
        :value="menu.page+1"
        :max="menu.totalPages"
    />
    <button
        v-if="hasNextPage"
        class="btn btn-secondary"
        @click="incrementPage(1)"
    >
        Next
    </button>
</template>

<style scoped>
</style>