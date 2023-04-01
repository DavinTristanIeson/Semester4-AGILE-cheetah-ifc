<script setup lang="ts">
defineProps<{
    class?: string,
}>();
const ID = Math.random().toString(16).substring(2);
const headingID = "accordion-heading-" + ID;
const bodyID = "accordion-body-" + ID;
</script>

<template>
<div class="accordion-item">
    <h2 class="accordion-header" :id="headingID">
        <button class="accordion-button p-3" :class="class" type="button" data-bs-toggle="collapse" :data-bs-target="`#${bodyID}`" aria-expanded="true" :aria-controls="bodyID">
            <slot name="header">
            </slot>
        </button>
    </h2>
    <div :id="bodyID" class="accordion-collapse collapse py-3 px-2 show" :aria-labelledby="headingID">
        <div class="accordion-body">
            <slot></slot>
        </div>
    </div>
</div>
</template>

<style>
.accordion-header:hover {
    outline: 2px solid white;
}
.accordion-header {
    background-color: var(--primary);
}
.accordion-collapse {
    background-color: var(--secondary-dark);
}
</style>