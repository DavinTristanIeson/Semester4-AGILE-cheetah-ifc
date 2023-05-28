<script setup lang="ts">
import { computed, inject, reactive, ref, watch } from 'vue';
import OrdersOffcanvas from './OrdersOffcanvas.vue';
import IconButton from '@/components/display/IconButton.vue';
import SearchBar from '@/components/display/SearchBar.vue';
import PageButtons from '@/components/function/PageButtons.vue';
import FilterPopup from '@/components/function/FilterPopup.vue';
import OrderDetail from './components/OrderDetail.vue';
import ScaleTransition from '@/components/display/ScaleTransition.vue';
import MenuItemComponent from './MenuItemComponent.vue';
import { CURRENT_ORDERS_KEY, MENU_CATEGORIES_KEY, MENU_PAGINATION_KEY } from '@/helpers/keys';

const isGridView = ref(localStorage.getItem("isGridView") == "false" ? false : true);

const params = reactive({
    search: "",
    category: ""
});

const menu = inject(MENU_PAGINATION_KEY)!;
const menuCategories = inject(MENU_CATEGORIES_KEY)!;
const currentOrders = inject(CURRENT_ORDERS_KEY)!;
const icon = computed(()=>{
    if (isGridView.value){
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

function setViewMode(){
    isGridView.value = !isGridView.value;
    localStorage.setItem("isGridView", isGridView.value.toString());
}
function refetch(){
    menu.refetch(params);
}
watch(params, refetch);
</script>

<template>
    <ScaleTransition>
        <OrderDetail v-if="currentOrders.viewedOrder"/>
    </ScaleTransition>
    <div class="d-flex align-items-center mw-70-lg">
        <SearchBar @search="params.search = $event" class="w-100 me-5"/>
        <div class="d-flex align-items-center me-4">
            <FilterPopup :options="menuCategories || []" @selected="params.category = $event"/>
            <IconButton
                :icon="icon.url"
                :semantic="icon.semantic"
                class="btn-secondary ms-2"
                @click="setViewMode"
            />
        </div>
    </div>
    <div class="menu-grid mw-70-lg" v-if="isGridView">
        <MenuItemComponent v-for="item in menu.data" :item="item" :isGridView="isGridView" :key="item.id"/>
    </div>
    <div class="mw-70-lg" v-else>
        <ul class="list-group">
            <MenuItemComponent v-for="item in menu.data" :item="item" :isGridView="isGridView" :key="item.id"/>
        </ul>
    </div>
    <PageButtons :injectKey="MENU_PAGINATION_KEY" :params="params"/>
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