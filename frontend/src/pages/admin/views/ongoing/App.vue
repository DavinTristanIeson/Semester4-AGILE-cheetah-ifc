<script setup lang="ts">
import { MenuItem, MenuOrder, MenuTransaction } from "@/helpers/classes";
import OngoingOrder from "./OngoingOrder.vue";
import { useOngoingOrdersStore, usePageStateStore } from "../../store";
import { onBeforeUnmount, reactive } from "vue";
import IconButton from "@/components/IconButton.vue";
import ChefModeListItem from "./ChefModeListItem.vue";
import { IntervalExecutor, socket } from "@/helpers/requests";
import { CONNECTION_ERROR, SERVER_ERROR } from "@/helpers/constants";


const orders = useOngoingOrdersStore();
const pageState = usePageStateStore();
const state = reactive({
    isChefMode: false,
});

pageState.setLoading(true);
const executor = new IntervalExecutor(orders.initialize)
    .on("success", () => {
        pageState.setLoading(false);
    })
    .on("failure", (e) => {
        console.error(e);
        pageState.setLoading(false);
        pageState.setError(CONNECTION_ERROR)
    });
executor.run();


socket.on("newOrder", (order) => {
    orders.addOrder(MenuTransaction.fromJSON(order));
});
onBeforeUnmount(() => {
    socket.off("newOrder");
    executor.cleanup();
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