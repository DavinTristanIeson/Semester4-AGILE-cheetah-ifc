<script setup lang="ts">
import { reactive } from 'vue';

const props = defineProps<{
    src: string;
    alt?: string;
}>();
const state = reactive({
    showOriginalImage: true,
});
function imageNotAvailable(){
    state.showOriginalImage = false;
}
</script>
<template>
    <img v-if="state.showOriginalImage" :src="src" :alt="alt || ''"
        class="modal-img" loading="lazy"
        @error="imageNotAvailable"
    >
    <img v-else src="@/assets/image-not-available.jpg" :alt="alt" class="modal-img">
</template>