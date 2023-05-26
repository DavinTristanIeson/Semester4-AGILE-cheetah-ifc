<script setup lang="ts">
import MenuListItem from '@/components/display/MenuListItem.vue';
import MenuCard from '@/components/display/MenuCard.vue';
import { useCurrentOrdersStore } from '../../store';
import type { MenuItem } from '@/helpers/classes';

const current = useCurrentOrdersStore();
const props = defineProps<{
    isGridView: boolean;
    item: MenuItem;
}>();
function addItem(){
    current.addOrder(props.item);
}
</script>

<template>
    <MenuCard v-if="isGridView" :item="item" @click="addItem"/>
    <MenuListItem v-else :item="item" @click="addItem"/>
</template>