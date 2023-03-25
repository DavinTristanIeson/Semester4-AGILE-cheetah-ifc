<script setup lang="ts">
import MenuCard from './MenuCard.vue';
import { MenuItem } from '@/helpers/classes';
import { computed, reactive } from 'vue';
import OrdersOffcanvas from './OrdersOffcanvas.vue';
import { useMenuStore } from '../../store';
import IconButton from '@/components/IconButton.vue';
import MenuListItem from './MenuListItem.vue';
import SearchBar from '@/components/SearchBar.vue';

const state = reactive({
    isGridView: true,
    searchTerm: "",
});
const menu = useMenuStore();
menu.menu = [
    new MenuItem(1, "Makanan", "Makanan", "Makanan", "none", 10000),
    new MenuItem(2, "Makanan B ", "Makanan B", "Makanan B", "none", 20000),
    new MenuItem(3, "Makanan C ", "Makanan C", "Makanan C", "none", 30000),
    new MenuItem(4, "Makanan D ", "Makanan D", "Makanan D", "none", 40000),
];

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
</script>

<template>
    <SearchBar v-model:value="menu.searchTerm"/>
    <div class="d-flex align-items-center">
        <IconButton
            :icon="icon.url"
            :semantic="icon.semantic"
            class="btn-primary"
            @click="state.isGridView = !state.isGridView"
        />
    </div>
    <div class="menu-grid" v-if="state.isGridView">
        <MenuCard v-for="item in menu.current" :item="item" :key="item.id"/>
    </div>
    <div class="menu-list" v-else>
        <ul class="list-group">
            <MenuListItem v-for="item in menu.current" :item="item" :key="item.id"/>
        </ul>
    </div>
    <OrdersOffcanvas/>
</template>

<style scoped>
.menu-grid {
    display: grid;
    grid-template-columns: 25% 25% 25% 25%;
}
@media screen and (min-width: 996px) {
    .menu-grid {
        max-width: 70%;
    }
}
</style>