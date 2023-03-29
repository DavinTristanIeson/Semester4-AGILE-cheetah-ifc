<script setup lang="ts">
import CheckboxInput from '@/components/CheckboxInput.vue';
import IconButton from '@/components/IconButton.vue';
import { CheckboxInputObject } from '@/helpers/inputs';
import { computed, reactive } from 'vue';
import { useMenuStore } from '../../store';
import ScaleTransition from '@/components/ScaleTransition.vue';

const menu = useMenuStore();
const input = computed(()=>{
    return new CheckboxInputObject(
        "",
        menu.filterCategories,
        menu.allCategories.map(category => ({label: category, value: category})),
        ()=>"",
    );
});
const state = reactive({
    isOpen: false,
});
function updateCategories(categories:string[]){
    menu.filterCategories = categories;
    menu.page = 0;
}
</script>

<template>
<div class="position-relative">
<IconButton
    icon="/filter.svg"
    semantic="Filter by category"
    class="btn-secondary"
    @click="state.isOpen = !state.isOpen"
/>
    <ScaleTransition>
        <div class="tss-bg-secondary rounded shadow p-3 pe-5 col-1 popup position-absolute"
            v-if="state.isOpen">
            <h5>Filter Berdasarkan Kategori</h5>
            <CheckboxInput :input="input" :value="menu.filterCategories" @update:value="updateCategories"/>
        </div>
    </ScaleTransition>
</div>
</template>

<style scoped>
.popup {
    width: fit-content;
    z-index: 3;
    top: 85%;
    left: 1%;
}
@media screen and (max-width: 996px) {
    .popup {
        top: 85%;
        left: -150%;
    }
}
</style>