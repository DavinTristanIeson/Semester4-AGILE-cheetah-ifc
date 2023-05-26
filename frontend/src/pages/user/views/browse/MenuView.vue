<script setup lang="ts">
import { computed, reactive } from 'vue';
import { useMenuStore } from '../../store';
import IconButton from '@/components/display/IconButton.vue';
import SearchBar from '@/components/display/SearchBar.vue';
import PageButtons from '../order/components/PageButtons.vue';
import FilterPopup from '../order/FilterPopup.vue';
import MenuCard from '@/components/display/MenuCard.vue';
import MenuListItem from '@/components/display/MenuListItem.vue';

const state = reactive({
    isGridView: localStorage.getItem("isGridView") == "false" ? false : true,
});
const menu = useMenuStore();

const icon = computed(()=>{
    if (state.isGridView){
        return {
            url: "/grid_view.svg",
            semantic: "Grid View"
        }
    } else {
        return {
            url: "/list.svg",
            semantic: "List View"
        }
    }
});

function setSearchTerm(searchTerm:string){
    menu.searchTerm = searchTerm;
    menu.page = 0;
}
function setViewMode(){
    state.isGridView = !state.isGridView;
    localStorage.setItem("isGridView", state.isGridView.toString());
}
</script>

<template>
    <div class="d-flex align-items-center mw-70-lg">
        <SearchBar @search="setSearchTerm" class="w-100 me-5"/>
        <div class="d-flex align-items-center me-4">
            <FilterPopup/>
            <IconButton
                :icon="icon.url"
                :semantic="icon.semantic"
                class="btn-secondary ms-2"
                @click="setViewMode"
            />
        </div>
    </div>
    <div class="menu-grid" v-if="state.isGridView">
        <MenuCard v-for="item in menu.current" :item="item" :key="item.id"/>
    </div>
    <div v-else>
        <ul class="list-group">
            <MenuListItem v-for="item in menu.current" :item="item" :key="item.id"/>
        </ul>
    </div>
    <PageButtons/>
</template>

<style>
.menu-grid {
    display: grid;
    grid-template-columns: 20% 20% 20% 20% 20%;
}
</style>