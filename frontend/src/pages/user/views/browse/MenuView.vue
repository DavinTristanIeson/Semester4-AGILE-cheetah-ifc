<script setup lang="ts">
import { computed, inject, reactive, ref, watch } from 'vue';
import IconButton from '@/components/display/IconButton.vue';
import SearchBar from '@/components/display/SearchBar.vue';
import PageButtons from '@/components/function/PageButtons.vue';
import FilterPopup from '@/components/function/FilterPopup.vue';
import MenuCard from '@/components/display/MenuCard.vue';
import MenuListItem from '@/components/display/MenuListItem.vue';
import ScaleTransition from '@/components/display/ScaleTransition.vue';
import { CURRENT_ORDERS_KEY, MENU_CATEGORIES_KEY, MENU_PAGINATION_KEY } from '@/helpers/keys';

const isGridView = ref(localStorage.getItem("isGridView") == "false" ? false : true);

const params = reactive({
    search: "",
    category: ""
});

const menu = inject(MENU_PAGINATION_KEY)!;
const menuCategories = inject(MENU_CATEGORIES_KEY)!;
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
    <div class="d-flex align-items-center">
        <SearchBar @search="params.search = $event" class="mw-70-lg me-5"/>
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
    <div class="guest-menu-grid w-100" v-if="isGridView">
        <MenuCard v-for="item in menu.data" :item="item" :isGridView="isGridView" :key="item.id"/>
    </div>
    <div class="w-100" v-else>
        <ul class="list-group">
            <MenuListItem v-for="item in menu.data" :item="item" :isGridView="isGridView" :key="item.id"/>
        </ul>
    </div>
    <PageButtons :injectKey="MENU_PAGINATION_KEY" :params="params"/>
</template>

<style>
.guest-menu-grid {
    display: grid;
    grid-template-columns: 20% 20% 20% 20% 20%;
}
.mw-70-lg {
    width: 100%;
}

@media screen and (min-width: 996px) {
    .mw-70-lg {
        width: 70%;
    }
}
</style>