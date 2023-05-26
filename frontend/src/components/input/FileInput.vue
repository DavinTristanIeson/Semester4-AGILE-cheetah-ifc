<script lang="ts" setup>
import type { FileInputObject, RadioInputObject } from '@/helpers/inputs';
import { ref } from 'vue';

const props = defineProps<{
    input: FileInputObject,
    shouldValidate?:boolean
}>();
const inputRef = ref(props.input);
const emit = defineEmits<{
    (e: "update:value", value:File|undefined): void,
}>();
function setValue(payload:Event){
    const target = payload.target as HTMLInputElement;
    inputRef.value.value = target.files?.[0];
    if (props.shouldValidate)
        inputRef.value.validate();
    emit("update:value", inputRef.value.value);
}
</script>


<template>
    <label className="fw-medium input-file w-100 my-3">
        <input
            type="file"
            :placeholder="input.label"
            :onChange="setValue"
            :accept="input.options.accept"
        />
        <span v-if="input.value">{{ input.value.name }}</span>
        <span v-else>{{ input.label }}</span>
    </label>
    <p class="fw-medium text-danger" v-if="input.error.length > 0">
        {{ input.error }}
    </p>
</template>

<style>
.input-file input[type=file] {
    display: none;
}
.input-file {
    border-radius: 10px;
    padding: 10px;
    border: none;
    width: 100%;
    box-sizing: border-box;
    outline: 0px solid black;
    transition: outline 0.3s, background-color 0.3s;
    background-color: var(--secondary);
    position: relative;
}
.input-file::after {
    content: 'Upload';
    position: absolute;
    top: 0%; right: 0%;
    height: 100%;
    display: flex;
    align-items: center;
    border-radius: 0px 10px 10px 0px;
    font-weight: bold;
    padding: 5px 10px 5px 10px;
    background-color: var(--primary);
}
</style>