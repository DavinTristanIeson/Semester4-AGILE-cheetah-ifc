<script setup lang="ts">
import { MenuOrder, MenuTransaction } from '@/helpers/classes';
import { CHEF_MODE_KEY, ONGOING_ORDERS_KEY } from '@/helpers/keys';
import { socket } from '@/helpers/requests';
import { computed, inject, onBeforeUnmount, reactive } from 'vue';
import IconButton from '@/components/display/IconButton.vue';
import { TransitionGroup } from 'vue';
import OngoingOrder from './OngoingOrder.vue';
import ChefModeListItem from './ChefModeListItem.vue';

const state = reactive({
    isChefMode: false,
});
const orders = inject(ONGOING_ORDERS_KEY)!;
const chefMode = inject(CHEF_MODE_KEY)!;
socket.on("newOrder", (order) => {
    orders.add(MenuTransaction.fromJSON(order));
});
onBeforeUnmount(() => {
    socket.off("newOrder");
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
                <ChefModeListItem :item="order.order" :earliest="order.earliest" :key="order.order.id" v-for="order in chefMode"/>
            </TransitionGroup>
        </div>
        <div v-else>
            <TransitionGroup name="list-slide-left">
                <OngoingOrder :order="order" :key="order.id" v-for="order in orders.data"/>
            </TransitionGroup>
        </div>
    </div>
</template>