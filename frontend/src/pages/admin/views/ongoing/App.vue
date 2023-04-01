<script setup lang="ts">
import { MenuItem, MenuOrder, MenuTransaction } from "@/helpers/classes";
import OngoingOrder from "./OngoingOrder.vue";
import { useOngoingOrdersStore } from "../../store";

const orders = useOngoingOrdersStore();
orders.initialize();
</script>

<template>
    <div class="mx-3 mt-4">
        <TransitionGroup name="list-slide-left">
            <OngoingOrder :order="order" :key="order.id" v-for="order in orders.orders"/>
        </TransitionGroup>
    </div>
</template>