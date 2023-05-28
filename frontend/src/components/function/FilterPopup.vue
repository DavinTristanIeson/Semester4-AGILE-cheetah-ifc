<script setup lang="ts">
import IconButton from '@/components/display/IconButton.vue';
import RadioInput from '../input/RadioInput.vue';
import { RadioInputObject } from '@/helpers/inputs';
import { computed, reactive } from 'vue';
import ScaleTransition from '@/components/display/ScaleTransition.vue';
import { formatFilterCategory } from '@/helpers/format';

const props = defineProps<{
    options: string[];
}>();
const emit = defineEmits<{
    (e: "selected", value: string): void;
}>();

const state = reactive({
    selected: "",
    isOpen: false,
});

const input = computed(()=>{
    const options = props.options.map(
        category => ({
            label: formatFilterCategory(category),
            value: category
        })
    );
    options.unshift({
        label: "Semua",
        value: "",
    });
    return new RadioInputObject(
        "",
        state.selected,
        options,
        "",
    );
});

function onSelected(selected: string){
    emit("selected", selected);
}
</script>

<template>
<div class="position-relative">
<IconButton
    icon="/filter.svg"
    semantic="Filter by category"
    class="btn-secondary"
    @click="state.isOpen = !state.isOpen"
/>
    <ScaleTransition>
        <div class="tss-bg-secondary rounded shadow p-3 pe-5 col-1 popup position-absolute"
            v-if="state.isOpen">
            <h5>Filter Berdasarkan Kategori</h5>
            <RadioInput :input="input" @update:value="onSelected"/>
        </div>
    </ScaleTransition>
</div>
</template>

<style>
.popup {
    width: fit-content;
    z-index: 3;
    top: 120%;
    left: 1%;
}
@media screen and (max-width: 996px) {
    .popup {
        left: -150%;
    }
}
</style>