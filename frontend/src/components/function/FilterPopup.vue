<script setup lang="ts">
import CheckboxInput from '@/components/input/CheckboxInput.vue';
import IconButton from '@/components/display/IconButton.vue';
import { CheckboxInputObject } from '@/helpers/inputs';
import { computed, reactive } from 'vue';
import { useMenuStore } from '@/helpers/menuStore';
import ScaleTransition from '@/components/display/ScaleTransition.vue';
import { formatFilterCategory } from '@/helpers/format';

const menu = useMenuStore();
const input = computed(()=>{
    return new CheckboxInputObject(
        "",
        menu.filterCategories,
        menu.allCategories.map(category => ({label: formatFilterCategory(category), value: category})),
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
            <CheckboxInput :input="input" :value="menu.filterCategories" @update:value="updateCategories" class="capitalize"/>
        </div>
    </ScaleTransition>
</div>
</template>

<style>
.popup {
    width: fit-content;
    z-index: 3;
    top: 120%;
    left: 1%;
}
@media screen and (max-width: 996px) {
    .popup {
        left: -150%;
    }
}
</style>