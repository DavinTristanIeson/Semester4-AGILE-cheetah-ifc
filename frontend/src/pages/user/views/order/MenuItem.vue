<script setup lang="ts">
import { inject } from 'vue';
import type { MenuItem } from '@/helpers/classes';
import MenuListItem from '@/components/MenuListItem.vue';
import MenuCard from '@/components/MenuCard.vue';
import { useCurrentOrdersStore } from '../../store';

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