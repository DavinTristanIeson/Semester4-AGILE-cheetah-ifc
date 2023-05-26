<script lang="ts" setup>
import type { FileInputObject, RadioInputObject, SelectInputObject } from '@/helpers/inputs';
import { ref } from 'vue';

const props = defineProps<{
    input: SelectInputObject<unknown>,
    shouldValidate?:boolean
}>();
const inputRef = ref(props.input);
const emit = defineEmits<{
    (e: "update:value", value:unknown|undefined): void,
}>();
function setValue(payload:Event){
    const target = payload.target as HTMLInputElement;
    inputRef.value.select(target.value);
    if (props.shouldValidate)
        inputRef.value.validate();
    emit("update:value", inputRef.value.value);
}
</script>


<template>
    <div class="form-group">
    <label :for="inputRef.id">{{ inputRef.label }}</label>
    <select class="form-control" :id="inputRef.id" @change="setValue">
        <option v-for="(_, key) of inputRef.selection" :key="key">
            {{ key }}
        </option>
    </select>
    </div>
</template>