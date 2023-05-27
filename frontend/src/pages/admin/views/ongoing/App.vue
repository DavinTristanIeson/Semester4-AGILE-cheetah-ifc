<script setup lang="ts">
import { MenuTransaction } from "@/helpers/classes";
import OngoingOrder from "./OngoingOrder.vue";
import { useOngoingOrdersStore } from "../../store";
import { onBeforeUnmount, reactive } from "vue";
import IconButton from "@/components/display/IconButton.vue";
import ChefModeListItem from "./ChefModeListItem.vue";
import { socket } from "@/helpers/requests";
import FetchWrapper from "@/components/function/FetchWrapper.vue";


const orders = useOngoingOrdersStore();
const state = reactive({
    isChefMode: false,
});

socket.on("newOrder", (order) => {
    orders.addOrder(MenuTransaction.fromJSON(order));
});
onBeforeUnmount(() => {
    socket.off("newOrder");
});
</script>

<template>
    <FetchWrapper :fn="orders.initialize">
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
    </FetchWrapper>
</template>