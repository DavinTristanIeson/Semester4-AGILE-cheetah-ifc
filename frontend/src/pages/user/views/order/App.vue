<script setup lang="ts">
import { onMounted, reactive } from 'vue';
import { useMenuStore } from '../../store';
import OrderView from "./OrderView.vue";
import WaitView from "./WaitView.vue";

const emit = defineEmits<{
    (e:"loading", value:boolean): void,
    (e:"error", value:string): void,
    (e:"success", value:string): void,
}>();


const state = reactive({
    isWaiting: false,
});
const menu = useMenuStore();
menu.initialize();
</script>

<template>
    <WaitView v-if="state.isWaiting"/>
    <OrderView v-else/>
</template>