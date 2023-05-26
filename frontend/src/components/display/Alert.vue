<script setup lang="ts">
defineProps<{
    message?:string,
    success?:boolean,
    floating?:boolean
    onClick?:()=>void,
}>();
</script>

<template>
    <div
        class="alert"
        :class="{
            'floating-alert': floating,
            'alert-success': success,
            'alert-danger': !success
        }"
        role="alert"
        v-if="message"
        @click="{onClick}"
    >
        <slot>{{ message }}</slot>
    </div>
</template>

<style>
.floating-alert {
    position: fixed;
    bottom: 3%;
    left: 50%;
    transform: translateX(-50%);
    width: 90%;
    max-width: 966px;
    text-align: center;
    z-index: 14;
}
</style>