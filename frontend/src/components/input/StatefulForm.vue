<script lang="ts" setup>
import type { CheckboxInputObject, InputObject, RadioInputObject, TextInputObject, NumberInputObject, FileInputObject, SelectInputObject } from "@/helpers/inputs";
import TextInput from "./TextInput.vue";
import RadioInput from "./RadioInput.vue";
import NumberInput from "./NumberInput.vue";
import SelectInput from "./SelectInput.vue";
import FileInput from "./FileInput.vue";
import { reactive } from "vue";
import CheckboxInput from "./CheckboxInput.vue";

type HttpMethods = "get"|"post"|"put"|"delete";
const props = defineProps<{
    action?:string
    method?: HttpMethods | Uppercase<HttpMethods>,
    inputs: InputObject[],
    validateFromStart?:boolean,
    purpose?:string,
}>();
const emit = defineEmits<{
    (e:"submit", response:{[key:string]: any}): void
}>();
const state = reactive({
    isValidating: props.validateFromStart ?? false,
});
function validate() {
    state.isValidating = true;
    let hasError = false;
    for (let input of props.inputs){
        input.validate();
        hasError = hasError || input.error.length > 0;
    }
    if (hasError) return;

    const response:{[key:string]: any} = {};
    props.inputs.forEach((x:any) => {response[x.label] = x.value;});
    emit("submit", response);
}
function isText(input:InputObject): input is TextInputObject {
    return input.type == "text";
}
function isRadio(input:InputObject): input is RadioInputObject {
    return input.type == "radio";
}
function isCheckbox(input:InputObject): input is CheckboxInputObject {
    return input.type == "checkbox";
}
function isNumber(input: InputObject): input is NumberInputObject {
    return input.type == "number"
}
function isSelect(input: InputObject): input is SelectInputObject {
    return input.type == "select"
}
function isFile(input: InputObject): input is FileInputObject {
    return input.type == "file"
}
</script>

<template>
    <div class="col-xl-6 bg-white col-lg-8 col-10 shadow px-3 rounded-2 py-4">
        <form :action="action" :method="method" class="needs-validation" autocomplete="off"
            novalidate @submit.prevent="validate">
            <slot name="header"></slot>
            <template v-for="input in inputs">
                <TextInput :input="input" v-if="isText(input)" :shouldValidate="state.isValidating"/>
                <RadioInput :input="input" v-if="isRadio(input)" :shouldValidate="state.isValidating"/>
                <CheckboxInput :input="input" v-if="isCheckbox(input)" :shouldValidate="state.isValidating"/>
                <NumberInput :input="input" v-if="isNumber(input)" :shouldValidate="state.isValidating"/>
                <SelectInput :input="input" v-if="isSelect(input)" :shouldValidate="state.isValidating"/>
                <FileInput :input="input" v-if="isFile(input)" :shouldValidate="state.isValidating"/>
            </template>
            <slot name="after"></slot>
            <input class="btn btn-primary w-100 py-2 fs-5" type="submit" :value="purpose"/>
            <slot name="footer"></slot>
        </form>
    </div>
</template>