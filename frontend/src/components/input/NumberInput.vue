<script setup lang="ts">
import { ref } from 'vue';
import type { NumberInputObject, TextInputObject } from '@/helpers/inputs';
const props = defineProps<{
    input:NumberInputObject,
    shouldValidate?:boolean
}>();
const emit = defineEmits<{
    (e: "update:value", value:number): void,
}>();
const inputRef = ref(props.input);
function setValue(payload:Event){
    const target = payload.target as HTMLInputElement;
    if (inputRef.value.options.isInteger) inputRef.value.value = parseFloat(target.value);
    else inputRef.value.value = parseInt(target.value);
    if (props.shouldValidate){
        inputRef.value.validate();
    }
    emit("update:value", inputRef.value.value);
}
</script>

<template>
<div class="form-floating my-3">
    <input
        class="form-control"
        :value="inputRef.value"
        :id="inputRef.id"
        @input="setValue"
    />
    <label :for="inputRef.id">{{ inputRef.label }}</label>
    <div v-if="inputRef.error" class="text-danger">{{ inputRef.error }}</div>
</div>
</template>