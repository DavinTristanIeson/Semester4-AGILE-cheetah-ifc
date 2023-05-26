<script lang="ts" setup>
import type { RadioInputObject } from '@/helpers/inputs';
import { ref } from 'vue';

const props = defineProps<{
    input:RadioInputObject,
    shouldValidate?:boolean
}>();
const inputRef = ref(props.input);
const emit = defineEmits<{
    (e: "update:value", value:string): void,
}>();
function setValue(payload:Event){
    const target = payload.target as HTMLInputElement;
    inputRef.value.value = target.value;
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
                    type="radio" :value="opt.value"
                    :id="opt.label + ' ' + inputRef.id"
                    :name="inputRef.id"
                    :checked="inputRef.value == opt.value"
                    @change="setValue"/>
            </div>
        </template>
        <div v-if="inputRef.error" class="text-danger">{{ inputRef.error }}</div>
    </div>
</template>