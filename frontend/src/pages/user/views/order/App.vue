<script setup lang="ts">
import MenuProvider from '@/components/function/MenuProvider.vue';
import OrdersProvider from './OrdersProvider.vue';
import View from "./View.vue";
</script>

<template>
    <OrdersProvider>
        <MenuProvider>
            <View />
        </MenuProvider>
    </OrdersProvider>
</template>