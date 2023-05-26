<script setup lang="ts">
import type { MenuItem } from '@/helpers/classes';

const props = defineProps<{
    item: MenuItem,
}>();
const emit = defineEmits<{
    (e: "click"): void
}>();
</script>

<template>
    <li class="my-2 ms-4 list-group-item rounded menu-list-item" @click="emit('click')" :title="item.description">
        <div class="d-flex justify-content-between">
            <h5>{{ item.name }}</h5>
            <p class="fs-6 text-muted">{{ item.harga }}</p>
        </div>
        <p class="card-text d-md-block d-none">{{ item.description }}</p>
    </li>
</template>

<style>
.menu-list-item {
    transition: transform 0.2s ease-out, color 0.2s ease-out;
    max-width: 90%;
}
.menu-list-item:hover {
    transform: translateX(1%);
    background-color: var(--secondary);
}
@media screen and (min-width: 996px) {
    .menu-list-item {max-width: 70%;}
}
</style>