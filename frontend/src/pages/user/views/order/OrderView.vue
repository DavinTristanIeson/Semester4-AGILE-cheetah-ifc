<script setup lang="ts">
import MenuCard from './MenuCard.vue';
import { MenuItem } from '@/helpers/classes';
import { reactive } from 'vue';
import OrdersOffcanvas from './OrdersOffcanvas.vue';

const state = reactive({
    item: new MenuItem(
        1,
        "Makanan",
        "Makanan",
        "Makanan",
        "sfsag",
        10000
    )
});
</script>

<template>
    <h1>Ordering</h1>
    <div class="menu-grid">
        <MenuCard :item="state.item"/>
    </div>
    <OrdersOffcanvas/>
</template>

<style scoped>
.menu-grid {
    display: grid;
    grid-template-columns: 25% 25% 25% 25%;
}
</style>