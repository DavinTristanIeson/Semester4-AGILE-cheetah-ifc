<script setup lang="ts">
import type { MenuOrder } from '@/helpers/classes';
import { computed, onBeforeUnmount, onMounted, reactive } from 'vue';

const props = defineProps<{
    item: MenuOrder,
    earliest: Date,
}>();
const state = reactive({
    intervalID: -1,
    timeDiff: new Date().getTime() - props.earliest.getTime(),
});
const notes = computed(()=>{
    return props.item.note.split('\n');
});
const earliestTime = computed(()=>{
    return props.earliest.toLocaleTimeString(undefined, {
        hour: "2-digit",
        minute: "2-digit",
        hour12: false,
    });
});
const perbedaanWaktu = computed(()=>{
    if (state.timeDiff < 1*60*60*1000){
        return `${Math.ceil(state.timeDiff / (60*1000))} menit yang lalu`;
    } else {
        return `${Math.ceil(state.timeDiff / (60*60*1000))} jam yang lalu`;
    }
});
onMounted(()=>{
    state.intervalID = setInterval(()=>{
        state.timeDiff = new Date().getTime() - props.earliest.getTime();
    }, 60*1000);
});
onBeforeUnmount(()=>{
    clearInterval(state.intervalID);
});
</script>

<template>
    <li class="list-group-item d-flex justify-content-between
        tss-bg-secondary my-1 sleek-shadow">
        <div class="text-start w-100">
            <b>{{ item.name }}</b>
            <hr>
            <ul class="text-muted chef-mode-notes-list ms-4 p-0">
                <li v-for="note in notes">{{ note }}</li>
            </ul>
        </div>
        <div class="tss-bg-primary rounded px-4 py-2">
            <div class="fs-4">x{{ item.quantity }}</div>
            <div class="fs-6" :class="{'text-danger': state.timeDiff > 1*60*60*1000}">Dari {{ perbedaanWaktu }}</div>
        </div>
    </li>
</template>

<style>
.chef-mode-notes-list {
    list-style-type: disc;
}
</style>