<script setup lang="ts">
import Accordion from '@/components/display/Accordion.vue';
import type { MenuTransaction } from "@/helpers/classes";
import { computed, onBeforeUnmount, onMounted, reactive } from 'vue';
import OrderListItem from '@/components/display/OrderListItem.vue';

const props = defineProps<{
    order: MenuTransaction
}>();
</script>
 
<template>
    <Accordion>
        <template v-slot:header>
            <span class="badge text-bg-secondary me-5">Finished</span>
            <p class="fw-bold m-0 p-0">
                {{ `Pesanan pada ${order.timeString}` }}
            </p>
        </template>
        <ul class="list-group mx-3">
            <OrderListItem :item="item" v-for="item in order.orders"/>
        </ul>
        <div class="my-2 mx-3 w-100"><b>Total: </b> {{ order.hargaTotal }}</div>
    </Accordion>
</template>

<style>
.flashing {
    animation: flashing 1s linear 0s infinite;
}
.flashingred {
    animation: flashingred 1s linear 0s infinite;
}
@keyframes flashing {
    from {background-color: var(--primary);}
    40% {background-color: var(--bs-secondary);}
    80% { background-color: var(--primary);}
    to { background-color: var(--primary);}
}

@keyframes flashingred {
    from {background-color: var(--primary);}
    40% {background-color: var(--bs-danger-bg-subtle);}
    80% { background-color: var(--primary);}
    to { background-color: var(--primary);}
}
</style>
