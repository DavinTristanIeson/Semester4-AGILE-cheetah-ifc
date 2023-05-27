<script setup lang="ts">
import FetchWrapper from '@/components/function/FetchWrapper.vue';
import { useMenuStore } from '@/helpers/menuStore';
import SearchBar from '@/components/display/SearchBar.vue';
import MenuListItem from '@/components/display/MenuListItem.vue';
import PageButtons from '@/components/function/PageButtons.vue';
import FAB from '@/components/display/FAB.vue';
import { reactive, type InjectionKey, inject } from 'vue';
import type { MenuItem } from '@/helpers/classes';
import EditMenuModal from './EditMenuModal.vue';
import type { EditMenuPayload } from './types';
import { PAGE_STATE_KEY, type PageState } from '@/components/function/keys';

const menu = useMenuStore();
const pageState = inject(PAGE_STATE_KEY)!;
const state = reactive({
    isEditing: false,
    viewedItem: undefined as MenuItem|undefined
});
function setSearchTerm(searchTerm:string){
    menu.searchTerm = searchTerm;
    menu.page = 0;
}
function editItem(payload: EditMenuPayload){
    pageState.run(async () => {
        // TODO: update at backend
    });
}
</script>

<template>
    <FetchWrapper :fn="menu.initialize" floating>
        <EditMenuModal :item="state.viewedItem" v-if="state.viewedItem"
            @close="state.viewedItem = undefined"
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
        <FAB src="/add.svg" @click="state.isEditing = true"/>
    </FetchWrapper>
</template>