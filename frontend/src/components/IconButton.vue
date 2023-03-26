<script setup lang="ts">
defineProps<{
    icon: string,
    semantic?: string,
    width?: number,
    height?: number,
}>();
defineEmits<{
    (e:"click"): void
}>();
</script>

<template>
    <button @click="$emit('click')" class="btn"
        :style="{
            '--icon-button-width': width ? `${width}em` : '1.4em',
            '--icon-button-height': height ? `${height}em` : '1.4em',
        }"
        :title="semantic ?? ''"
    >
        <img :src="icon" :alt="semantic ?? ''">
    </button>
</template>

<style scoped>
img {
    width: var(--icon-button-width);
    height: var(--icon-button-height);
}
</style>