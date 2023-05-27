<script setup lang="ts">
import type { MenuItem } from '@/helpers/classes';
import { reactive } from 'vue';

const props = defineProps<{
    item: MenuItem
}>();
const emit = defineEmits<{
    (e: "click"): void
}>();
const state = reactive({
    showOriginalImage: true
});

function imageNotAvailable(){
    state.showOriginalImage = false;
}
</script>

<template>
    <div class="card m-2" @click="emit('click')" :title="item.description">
        <div class="card-img-top-wrapper">
            <img
                v-if="state.showOriginalImage"
                :src="item.img" :alt="item.name"
                class="card-img-top" loading="lazy"
                @error="imageNotAvailable">
            <img
                v-else
                src="@/assets/image-not-available.jpg"
                :alt="item.name"
                class="card-img-top">
        </div>
        <div class="card-body">
            <h5 class="card-title">{{ item.name }}</h5>
            <p class="card-subtitle fs-6 text-muted">{{ item.harga }}</p>
            <p class="card-text d-md-block d-none">{{ item.description }}</p>
        </div>
    </div>
</template>

<style>
.card-img-top {
    background-color: var(--primary);
    /* height: 75%; */

    /* https://stackoverflow.com/questions/36305805/how-to-hide-alt-text-using-css-when-the-image-is-not-present */
    text-indent: 100%;
    white-space: nowrap;
    overflow: hidden;
}
.card {transition: transform 0.2s ease-out, background-color 0.2s ease-out;}
.card:hover {
    transform: scale(105%, 105%);
    background-color: var(--secondary);
}
.card-img-top-wrapper {overflow: hidden; border-radius: var(--bs-card-border-radius);}
.card-img-top {transition: transform 0.2s ease-out;}
.card-img-top-wrapper img:hover {
    transform: scale(110%, 110%);
    filter: brightness(110%)
}
</style>