<script lang="ts" setup>
import type { CheckboxInputObject } from '@/helpers/inputs';
import { ref } from 'vue';

const props = defineProps<{
    input:CheckboxInputObject,
    shouldValidate?:boolean,
}>();
const inputRef = ref(props.input);
const emit = defineEmits<{
    (e: "update:value", value:string[]): void,
}>();
function setValue(payload:Event){
    const target = payload.target as HTMLInputElement;

    const idx = inputRef.value.value.findIndex(x => x == target.value);
    if (idx == -1) inputRef.value.value.push(target.value);
    else inputRef.value.value.splice(idx, 1);
    if (props.shouldValidate)
        inputRef.value.validate();
    
    emit("update:value", inputRef.value.value);
}
</script>

<template>
    <div class="mb-3">
        {{ inputRef.label }}
        <template v-for="opt in inputRef.options">
            <div class="form-check">
                <label
                    class="form-check-label"
                    :for="opt.label + ' ' + inputRef.id"
                >{{ opt.label }}</label>
                <input
                    class="form-check-input"
                    type="checkbox" :value="opt.value"
                    :id="opt.label + ' ' + inputRef.id"
                    :name="inputRef.id"
                    :checked="inputRef.value.includes(opt.value)"
                    @change="setValue"/>
            </div>
        </template>
        <div v-if="inputRef.error" class="text-danger">{{ inputRef.error }}</div>
    </div>
</template>