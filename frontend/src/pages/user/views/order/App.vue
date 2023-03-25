<script setup lang="ts">
import { onMounted, reactive } from 'vue';
import OrderView from "./OrderView.vue";
import WaitView from "./WaitView.vue";

const state = reactive({
    isWaiting: false,
});
onMounted(()=>{
    // TODO: GET menu item
})
</script>

<template>
    <WaitView v-if="state.isWaiting"/>
    <OrderView v-else/>
</template>