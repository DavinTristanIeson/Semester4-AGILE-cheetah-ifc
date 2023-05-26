<script setup lang="ts">
defineProps<{
    loading: boolean
}>();
</script>

<template>
    <div class="spinner-border text-primary" role="status"
        v-if="loading">
        <span class="visually-hidden">Loading...</span>
    </div>
</template>

<style>
.spinner-border {
    position: absolute;
    top: 48%; left: 48%;
    z-index: 15;
}
@media screen and (min-width: 576px){
    .spinner-border {
        width: 3em;
        height: 3em;
        --bs-spinner-border-width: 0.4em;
    }
}
@media screen and (min-width: 768px){
    .spinner-border {
        width: 4em;
        height: 4em;
        --bs-spinner-border-width: 0.6em;
    }
}
@media screen and (min-width: 992px){
    .spinner-border {
        width: 5em;
        height: 5em;
        --bs-spinner-border-width: 0.8em;
    }
}
</style>