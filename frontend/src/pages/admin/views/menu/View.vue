<script setup lang="ts">
import { MenuItem } from '@/helpers/classes';
import { API, SERVER_ERROR } from '@/helpers/constants';
import { MENU_PAGINATION_KEY, PAGE_STATE_KEY } from '@/helpers/keys';
import { inject, reactive } from 'vue';
import type { EditMenuPayload } from './types';
import MenuListItem from '@/components/display/MenuListItem.vue';
import EditMenuModal from './EditMenuModal.vue';
import SearchBar from '@/components/display/SearchBar.vue';
import PageButtons from '@/components/function/PageButtons.vue';
import FAB from '@/components/display/FAB.vue';

const menu = inject(MENU_PAGINATION_KEY)!;
const pageState = inject(PAGE_STATE_KEY)!;
const state = reactive({
    isEditing: false,
    viewedItem: undefined as MenuItem|undefined|null
});
function setSearchTerm(searchTerm:string){
    menu.refetch({search: searchTerm});
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
            if (!res.ok) throw new Error(SERVER_ERROR);
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
            if (!res.ok) throw new Error(SERVER_ERROR);
            if (menu.page != menu.totalPages - 1) return;
            const raw = await res.json();
            menu.data.push(MenuItem.fromJSON(raw));
            
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
        if (!res.ok) throw new Error(SERVER_ERROR);

        state.viewedItem = undefined;
        const idx = menu.data.findIndex(x => x.id == id);
        if (idx == -1) return;
        menu.data.splice(idx, 1);
    });
}
</script>

<template>
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
                v-for="item in menu.data"
                :item="item" :key="item.id"
                @click="state.viewedItem = item"/>
        </ul>
    </div>
    <PageButtons :injectKey="MENU_PAGINATION_KEY" />
    <FAB src="/add.svg" @click="state.viewedItem = null"/>
</template>