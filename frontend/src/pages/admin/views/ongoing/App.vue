<script setup lang="ts">
import { MenuItem, MenuOrder, MenuTransaction } from "@/helpers/classes";
import OngoingOrder from "./OngoingOrder.vue";
import { useOngoingOrdersStore } from "../../store";
import { onBeforeUnmount, reactive } from "vue";
import IconButton from "@/components/IconButton.vue";
import ChefModeListItem from "./ChefModeListItem.vue";
import { IntervalExecutor } from "@/helpers/requests";
import { CONNECTION_ERROR, SERVER_ERROR } from "@/helpers/constants";

const emit = defineEmits<{
    (e:"loading", value:boolean): void,
    (e:"error", message:string, timeout:number|null): void,
    (e:"success", message:string, timeout:number|null): void,
}>();
const orders = useOngoingOrdersStore();
const state = reactive({
    isChefMode: false,
});

emit("loading", true);
const executor = new IntervalExecutor(orders.initialize)
    .on("success", () => {
        if (!orders.areOrdersInitialized){
            emit("error", SERVER_ERROR, 3000);
        } else {
            emit("loading", false)
            emit("error", "", null);
        }
    })
    .on("failure", (e) => {
        console.error(e);
        emit("error", CONNECTION_ERROR, null);
    });
executor.run();
onBeforeUnmount(() => {
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