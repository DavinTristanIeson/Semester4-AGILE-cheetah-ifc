<script setup lang="ts">
defineProps<{
    src: string;
    alt?: string;
}>();
defineEmits<{
    (e: "click"): void
}>();

</script>

<template>
    <button class="fab shadow" @click="$emit('click')">
        <img :src="src" :alt="alt || ''" />
    </button>
</template>

<style>
.fab {
    border-radius: 50%;
    background-color: var(--primary);
    width: 48px;
    height: 48px;

    position: fixed;
    right: 0%;
    bottom: 0%;
    margin-right: 40px;
    margin-bottom: 40px;

    border: none;
    transition: background-color 0.2, transform 0.2s;
}
.fab img {
    width: 60%;
    height: 60%;
}
.fab:hover {
    background-color: var(--primary-dark);
    transform: scale(102%, 102%);
}
@media screen and (min-width: 1200px){
    .fab {
        width: 128px;
        height: 128px;
    }
}
@media screen and (max-width: 996px){
    .fab {
        width: 96px;
        height: 96px;
    }
}
@media screen and (max-width: 720px){
    .fab {
        width: 64px;
        height: 64px;
    }
}
</style>