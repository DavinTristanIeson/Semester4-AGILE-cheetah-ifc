<script setup lang="ts">
import MenuCard from './MenuCard.vue';
import { MenuItem } from '@/helpers/classes';
import { computed, reactive } from 'vue';
import OrdersOffcanvas from './OrdersOffcanvas.vue';
import { useCurrentOrdersStore, useMenuStore } from '../../store';
import IconButton from '@/components/IconButton.vue';
import MenuListItem from './MenuListItem.vue';
import SearchBar from '@/components/SearchBar.vue';
import PageButtons from './PageButtons.vue';
import FilterPopup from './FilterPopup.vue';
import OrderDetail from './OrderDetail.vue';
import ScaleTransition from '@/components/ScaleTransition.vue';

const state = reactive({
    isGridView: localStorage.getItem("isGridView") == "false" ? false : true,
});
const menu = useMenuStore();
const currentOrders = useCurrentOrdersStore();

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
    <ScaleTransition>
        <OrderDetail v-if="currentOrders.viewedOrder"/>
    </ScaleTransition>
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
    <div class="menu-grid mw-70-lg" v-if="state.isGridView">
        <MenuCard v-for="item in menu.current" :item="item" :key="item.id"/>
    </div>
    <div class="mw-70-lg" v-else>
        <ul class="list-group">
            <MenuListItem v-for="item in menu.current" :item="item" :key="item.id"/>
        </ul>
    </div>
    <PageButtons/>
    <OrdersOffcanvas/>
</template>

<style scoped>
.menu-grid {
    display: grid;
    grid-template-columns: 25% 25% 25% 25%;
}
.mw-70-lg {
    max-width: 100%;
}

@media screen and (min-width: 996px) {
    .mw-70-lg {
        max-width: 70%;
    }
}
</style>