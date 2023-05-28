<script lang="ts" setup>
import type { FileInputObject, RadioInputObject, SelectInputObject } from '@/helpers/inputs';
import { ref } from 'vue';

const props = defineProps<{
    input: SelectInputObject,
    shouldValidate?:boolean
}>();
const inputRef = ref(props.input);
const emit = defineEmits<{
    (e: "update:value", value:unknown|undefined): void,
}>();
function setValue(e: Event){
    const target = e.target as HTMLInputElement;
    inputRef.value.value = target.value;
    if (props.shouldValidate)
        inputRef.value.validate();
    emit("update:value", inputRef.value.value);
}
</script>


<template>
    <div class="form-group">
    <label :for="inputRef.id">{{ inputRef.label }}</label>
    <select class="form-control" :id="inputRef.id" @change="setValue" :value="inputRef.value">
        <option v-for="opt in inputRef.selection" :value="opt.value">
            {{ opt.label }}
        </option>
    </select>
    </div>
</template>