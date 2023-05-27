<script setup lang="ts">
import { computed, reactive } from 'vue';

const props = defineProps<{
    src: string;
    alt?: string;
}>();
const emit = defineEmits<{
    (e: "load"): void;
    (e: "error"): void;
}>();
const state = reactive({
    brokenSrc: undefined as string | undefined,
    showOriginalImage: true,
});
function imageNotAvailable(){
    state.showOriginalImage = false;
    state.brokenSrc = props.src;
    emit("error");
}
</script>
<template>
    <img v-if="state.showOriginalImage || src != state.brokenSrc" :src="src" :alt="alt || ''"
        class="modal-img" loading="lazy"
        @load="$emit('load')"
        @error="imageNotAvailable"
    >
    <img v-else src="@/assets/image-not-available.jpg" :alt="alt" class="modal-img">
</template>