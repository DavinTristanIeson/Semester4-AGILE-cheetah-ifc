<script setup lang="ts">
import { MenuItem, MenuOrder, MenuTransaction } from "@/helpers/classes";
import OngoingOrder from "./OngoingOrder.vue";
import { useOngoingOrdersStore } from "../../store";
import { reactive } from "vue";
import IconButton from "@/components/IconButton.vue";
import ChefModeListItem from "./ChefModeListItem.vue";

const orders = useOngoingOrdersStore();
orders.initialize();

const state = reactive({
    isChefMode: false,
});
</script>

<template>
    <div class="mx-3 mx-lg-5 mt-4">
        <div class="mb-4 ms-2">
            <IconButton
                icon="/restaurant.svg" 
                semantic="Chef Mode"
                class="btn-primary"
                @click="state.isChefMode = true"
                v-if="!state.isChefMode"
            />
            <IconButton
                icon="/storefront.svg" 
                semantic="Store Mode"
                class="btn-primary"
                @click="state.isChefMode = false"
                v-else
            />
        </div>
        <div v-if="state.isChefMode">
            <TransitionGroup name="list-slide-left" tag="ul" class="list-group">
                <ChefModeListItem :item="order.order" :earliest="order.earliest" :key="order.order.id" v-for="order in orders.chefMode"/>
            </TransitionGroup>
        </div>
        <div v-else>
            <TransitionGroup name="list-slide-left">
                <OngoingOrder :order="order" :key="order.id" v-for="order in orders.orders"/>
            </TransitionGroup>
        </div>
    </div>
</template>