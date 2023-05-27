<script setup lang="ts">
import { ref } from 'vue';
import type { TextInputObject } from '@/helpers/inputs';
const props = defineProps<{
    input:TextInputObject,
    shouldValidate?:boolean
}>();
const emit = defineEmits<{
    (e: "update:value", value:string): void,
}>();
const inputRef = ref(props.input);
function setValue(payload:Event){
    const target = payload.target as HTMLInputElement;
    inputRef.value.value = target.value;
    if (props.shouldValidate){
        inputRef.value.validate();
    }
    emit("update:value", inputRef.value.value);
}
</script>

<template>
<div class="form-floating my-3" v-if="!inputRef.options.isTextarea">
    <input
        class="form-control"
        :type="inputRef.options.semanticType ?? 'text'"
        :placeholder="inputRef.options.placeholder"
        :value="inputRef.value"
        :id="inputRef.id"
        @input="setValue"
    />
    <label :for="inputRef.id">{{ inputRef.label }}</label>
    <div v-if="inputRef.error" class="text-danger">{{ inputRef.error }}</div>
</div>
<div class="my-3" v-else>
    <label :for="inputRef.id">{{ inputRef.label }}</label>
    <textarea
        class="form-control"
        :value="inputRef.value"
        :placeholder="inputRef.options.placeholder"
        @input="setValue"
        >
    </textarea>
    <div v-if="inputRef.error" class="text-danger">{{ inputRef.error }}</div>
</div>
</template>