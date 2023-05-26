<script setup lang="ts">
import type { MenuItem } from '@/helpers/classes';
import MaybeImage from './MaybeImage.vue';

defineProps<{
    item: MenuItem
}>();
defineEmits<{
    (e: "close"): void
}>();
</script>
<template>
    <div class="modal modal-lg d-block" tabindex="-1"
        aria-hidden="true" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header tss-bg-secondary">
                    <h5 class="modal-title">{{ item.name }}</h5>
                    <button class="btn-close" @click="$emit('close')"></button>
                </div>
                <div class="modal-body">
                    <div class="d-flex mb-3">
                        <MaybeImage :src="item.img" :alt="item.name" class="modal-img"/>
                        <slot name="side">
                            <div class="mx-3">
                                <p class="fs-6 mb-2">{{ item.description }}</p>
                                <p class="fs-6 mb-0"><i>{{ item.harga }}</i></p>
                                <slot name="side-under"></slot>
                            </div>
                        </slot>
                    </div>
                    <slot name="under"></slot>
                </div>
                <div class="modal-footer">
                    <slot name="footer"></slot>
                </div>
            </div>
        </div>
    </div>
</template>

<style>
.modal-img {
    max-width: 300px;
}
</style>