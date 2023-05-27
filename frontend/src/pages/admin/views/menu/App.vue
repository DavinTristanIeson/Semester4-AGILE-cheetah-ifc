<script setup lang="ts">
import FetchWrapper from '@/components/function/FetchWrapper.vue';
import { useMenuStore } from '@/helpers/menuStore';
import SearchBar from '@/components/display/SearchBar.vue';
import MenuListItem from '@/components/display/MenuListItem.vue';
import PageButtons from '@/components/function/PageButtons.vue';
import FAB from '@/components/display/FAB.vue';
import { reactive, type InjectionKey, inject } from 'vue';
import { MenuItem } from '@/helpers/classes';
import EditMenuModal from './EditMenuModal.vue';
import type { EditMenuPayload } from './types';
import { PAGE_STATE_KEY, type PageState } from '@/components/function/keys';
import { API, SERVER_ERROR } from '@/helpers/constants';

const menu = useMenuStore();
const pageState = inject(PAGE_STATE_KEY)!;
const state = reactive({
    isEditing: false,
    viewedItem: undefined as MenuItem|undefined|null
});
function setSearchTerm(searchTerm:string){
    menu.searchTerm = searchTerm;
    menu.page = 0;
}
function editItem(payload: EditMenuPayload, original: MenuItem | null){
    pageState.run(async () => {
        if (original){
            const res = await fetch(`${API}/menu/${original.id}`, {
                method: "PUT",
                body: JSON.stringify(payload),
                credentials: "include",
                headers: {
                    'Content-Type': "application/json",
                },
            });
            if (!res.ok) return new Error(SERVER_ERROR);
            original.name = payload.name;
            original.description = payload.description;
            original.price = payload.price;
            original.category = payload.category;
            original.img = payload.img;
        } else {
            const res = await fetch(`${API}/menu`, {
                method: "POST",
                body: JSON.stringify(payload),
                credentials: 'include',
                headers: {
                    'Content-Type': "application/json",
                },
            });
            if (!res.ok) return new Error(SERVER_ERROR);
            const raw = await res.json();
            menu.add(MenuItem.fromJSON(raw));
        }
        state.viewedItem = undefined;
    });
}
function deleteItem(id: number){
    if (!confirm("Apakah anda yakin anda ingin menghapus item menu ini?")) return;
    pageState.run(async () => {
        const res = await fetch(`${API}/menu/${id}`, {
            method: "DELETE",
            headers: {
                'Content-Type': "application/json",
            },
            credentials: "include"
        });
        if (!res.ok) return new Error(SERVER_ERROR);
        menu.remove(id);
        state.viewedItem = undefined;
    });
}
</script>

<template>
    <FetchWrapper :fn="menu.initialize">
        <EditMenuModal :item="state.viewedItem" v-if="state.viewedItem !== undefined"
            @close="state.viewedItem = undefined"
            @delete="deleteItem"
            @edit="editItem"/>
        <div class="d-flex align-items-center mw-70-lg">
            <SearchBar @search="setSearchTerm" class="w-100 me-5"/>
        </div>
        <div>
            <ul class="list-group">
                <MenuListItem
                    v-for="item in menu.current"
                    :item="item" :key="item.id"
                    @click="state.viewedItem = item"/>
            </ul>
        </div>
        <PageButtons/>
        <FAB src="/add.svg" @click="state.viewedItem = null"/>
    </FetchWrapper>
</template>