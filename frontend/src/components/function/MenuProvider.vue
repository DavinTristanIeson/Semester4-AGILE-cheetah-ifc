<script setup lang="ts">
import { MenuItem } from '@/helpers/classes';
import Pagination from './Pagination.vue';
import type { PaginatedApiResult } from "@/helpers/requests";
import { API } from '@/helpers/constants';
import { type MenuPaginationParams, MENU_CATEGORIES_KEY, MENU_PAGINATION_KEY } from "@/helpers/keys";
import FetchWrapper from './FetchWrapper.vue';

async function fetchMenu(page: number, params?: MenuPaginationParams){
    const query = new URLSearchParams();
    query.append("page", page.toString());
    params?.search && query.append("search", params.search);
    params?.category && query.append("category", params.category);

    const res = await fetch(`${API}/menu?${query.toString()}`);
    if (!res.ok) throw res;
    const json:PaginatedApiResult<object[]> = await res.json();
    return {
        pages: json.pages,
        data: json.data.map(x => MenuItem.fromJSON(x))
    }
}
async function fetchCategories(){
    const res = await fetch(`${API}/menu/categories`);
    if (!res.ok) throw res;
    return await res.json();
}
</script>

<template>
    <FetchWrapper :fn="fetchCategories" :injectKey="MENU_CATEGORIES_KEY">
        <Pagination :fn="fetchMenu" :injectKey="MENU_PAGINATION_KEY">
            <slot></slot>
        </Pagination>
    </FetchWrapper>
</template>