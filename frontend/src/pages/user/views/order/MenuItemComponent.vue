<script setup lang="ts">
import MenuListItem from '@/components/display/MenuListItem.vue';
import MenuCard from '@/components/display/MenuCard.vue';
import type { MenuItem } from '@/helpers/classes';
import { CURRENT_ORDERS_KEY } from '@/helpers/keys';
import { inject } from 'vue';

const current = inject(CURRENT_ORDERS_KEY)!;
const props = defineProps<{
    isGridView: boolean;
    item: MenuItem;
}>();
function addItem(){
    current.add(props.item);
}
</script>

<template>
    <MenuCard v-if="isGridView" :item="item" @click="addItem"/>
    <MenuListItem v-else :item="item" @click="addItem"/>
</template>