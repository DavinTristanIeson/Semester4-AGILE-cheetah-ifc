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
    let temp;
    if (inputRef.value.options.isInteger) temp = parseFloat(target.value);
    else temp = parseInt(target.value);
    if (isNaN(temp)){
        inputRef.value.value = inputRef.value.value;
    } else {
        inputRef.value.value = temp;
    }
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
        type="number"
        :value="inputRef.value"
        :id="inputRef.id"
        @input="setValue"
    />
    <label :for="inputRef.id">{{ inputRef.label }}</label>
    <div v-if="inputRef.error" class="text-danger">{{ inputRef.error }}</div>
</div>
</template>