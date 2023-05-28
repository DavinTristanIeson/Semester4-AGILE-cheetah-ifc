<script setup lang="ts">
import { MenuTransaction, MenuOrder, type MenuItem } from '@/helpers/classes';
import { inject, provide, reactive, ref } from 'vue';
import { CURRENT_ORDERS_KEY, MENU_CATEGORIES_KEY, PAGE_STATE_KEY } from "@/helpers/keys";
import { API } from '@/helpers/constants';
import FetchWrapper from '@/components/function/FetchWrapper.vue';

const state = reactive({
    current: null as MenuTransaction | null,
    orders: [] as MenuOrder[],
    viewedOrder: undefined as (MenuOrder | undefined),
    add, remove, examine,
    createTransaction, finishTransaction, cancelTransaction
});
const isFetching = ref(true);

const pageState = inject(PAGE_STATE_KEY)!;

function add(item: MenuItem) {
    let findme = state.orders.find(order => order.id == item.id);
    if (findme) findme.quantity++;
    else state.orders.push(new MenuOrder(item));
}
function remove(order: MenuOrder) {
    let idx = state.orders.indexOf(order);
    if (idx == -1) return;
    state.orders.splice(idx, 1);
}
function examine(order: MenuOrder | undefined) {
    state.viewedOrder = order;
}
async function createTransaction() {
    state.viewedOrder = undefined;
    pageState.run(async () => {
        const res = await fetch(API + '/orders', {
            method: "POST",
            headers: {
                'Content-Type': "application/json",
            },
            credentials: "include",
            body: JSON.stringify(state.orders.map(x => ({
                name: x.name,
                price: x.price,
                quantity: x.quantity,
                note: x.note,
            })))
        });
        if (!res.ok) throw res;
        const json = await res.json();
        state.current = MenuTransaction.fromJSON(json);
        state.orders = [];
    });
}
async function finishTransaction() {
    state.current = null;
}
async function cancelTransaction(){
    if (!state.current) return;
    state.orders = state.current.orders;
    state.current = null;
}
async function initialize() {
    const res = await fetch(API + "/orders/ongoing", { credentials: "include" });
    if (!res.ok) return;
    const json = await res.json();
    state.current = MenuTransaction.fromJSON(json);
    isFetching.value = false;
}
provide(CURRENT_ORDERS_KEY, state);
initialize();
</script>

<template>
    <slot></slot>
</template>