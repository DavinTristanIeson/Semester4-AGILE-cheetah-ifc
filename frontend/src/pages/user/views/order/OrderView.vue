<script setup lang="ts">
import { computed, reactive } from 'vue';
import OrdersOffcanvas from './OrdersOffcanvas.vue';
import { useCurrentOrdersStore } from '../../store';
import { useMenuStore } from '@/helpers/menuStore';
import IconButton from '@/components/display/IconButton.vue';
import SearchBar from '@/components/display/SearchBar.vue';
import PageButtons from '@/components/function/PageButtons.vue';
import FilterPopup from '@/components/function/FilterPopup.vue';
import OrderDetail from './components/OrderDetail.vue';
import ScaleTransition from '@/components/display/ScaleTransition.vue';
import MenuItemComponent from './MenuItemComponent.vue';

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
        <MenuItemComponent v-for="item in menu.current" :item="item" :isGridView="state.isGridView" :key="item.id"/>
    </div>
    <div class="mw-70-lg" v-else>
        <ul class="list-group">
            <MenuItemComponent v-for="item in menu.current" :item="item" :isGridView="state.isGridView" :key="item.id"/>
        </ul>
    </div>
    <PageButtons/>
    <OrdersOffcanvas/>
</template>

<style>
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