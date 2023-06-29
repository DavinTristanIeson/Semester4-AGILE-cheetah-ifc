<script setup lang="ts">
import { MenuOrder, MenuTransaction } from "@/helpers/classes";
import FetchWrapper from "@/components/function/FetchWrapper.vue";
import { API } from "@/helpers/constants";
import View from "./View.vue";
import { CHEF_MODE_KEY, ONGOING_ORDERS_KEY, PAGE_STATE_KEY } from "@/helpers/keys";
import { computed, inject, provide, reactive } from 'vue';

const state = reactive({
    data: [] as MenuTransaction[],
    add, remove
});
const pageState = inject(PAGE_STATE_KEY)!;

function add(order: MenuTransaction){
    state.data.push(order);
}
function remove(order: MenuTransaction){
    const idx = state.data.findIndex(x => x.id == order.id);
    if (idx == -1) return;
    state.data.splice(idx, 1);
}

function initialize() {
    pageState.run(async () => {
        const res = await fetch(API + "/orders/chef", {
            credentials: "include",
        });
        if (!res.ok) throw res;
        const json = await res.json();
        state.data = MenuTransaction.fromJSONArray(json);
    });
}

function isOverAnHour(time: Date) {
    return new Date().getTime() - time.getDate() > 1 * 60 * 60 * 1000;
}
const chefMode = computed(() => {
    const uniques: { [key: string]: { earliest: Date, order: MenuOrder, recipients: string[] } } = {};
    for (let ord of state.data) {
        for (let item of ord.orders) {
            if (uniques.hasOwnProperty(item.name)) {
                uniques[item.name].order.quantity += item.quantity;
                if (!uniques[item.name].recipients.includes(ord.username)){
                    uniques[item.name].order.note += '\n' + `(oleh: ${ord.username}) ${item.note}`;
                    uniques[item.name].recipients.push(ord.username);
                }
                uniques[item.name].earliest = (uniques[item.name].earliest.getTime() <= ord.time.getTime() ? uniques[item.name].earliest : ord.time);
            } else {
                uniques[item.name] = {
                    order: item.copy(),
                    earliest: ord.time,
                    recipients: [ord.username],
                };
                uniques[item.name].order.note = `(oleh: ${ord.username}) ${item.note}`;
            }
        }
    }
    const priorityList: { earliest: Date, order: MenuOrder }[] = [];
    for (let uniq in uniques) {
        priorityList.push(uniques[uniq]);
    }

    priorityList.sort((a, b) => {
        const lateA = isOverAnHour(a.earliest);
        const lateB = isOverAnHour(b.earliest);
        if (lateA == lateB) return b.order.quantity - a.order.quantity;
        else if (lateA) return -1;
        else return 1;
    });
    return priorityList;
});

initialize();
provide(ONGOING_ORDERS_KEY, state);
provide(CHEF_MODE_KEY, chefMode);
</script>

<template>
    <View />
</template>