<script setup lang="ts">
defineProps<{
    icon: string,
    semantic?: string,
    width?: number,
    height?: number,
}>();
defineEmits<{
    (e:"click", ev:MouseEvent): void
}>();
</script>

<template>
    <button @click="$emit('click', $event)" class="btn icon-btn"
        :style="{
            '--icon-button-width': width ? `${width}em` : '1.4em',
            '--icon-button-height': height ? `${height}em` : '1.4em',
        }"
        :title="semantic ?? ''"
    >
        <img :src="icon" :alt="semantic ?? ''">
    </button>
</template>

<style>
.icon-btn>img {
    width: var(--icon-button-width);
    height: var(--icon-button-height);
}
</style>