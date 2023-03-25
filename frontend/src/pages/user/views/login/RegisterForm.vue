<script setup lang="ts">
import StatefulForm from '@/components/StatefulForm.vue';
import { RadioInputObject, TextInputObject } from '@/helpers/inputs';
import { validateEmail, validateName, validatePassword, validatePhoneNumber } from "@/helpers/inputValidators"
import Alert from '@/components/Alert.vue';
import { reactive } from 'vue';

const emit = defineEmits<{
    (e:"changemode"): void
}>();

const inputs = [
    new TextInputObject("Email", "", validateEmail, {
        semanticType: "email"
    }),
    new TextInputObject("Password", "", validatePassword, {
        semanticType: "password"
    }),
    new TextInputObject("Nama", "", validateName),
    new RadioInputObject("Jenis Kelamin", "", [
        { label: "Pria", value:"male" },
        { label: "Wanita", value:"female" }
    ], "Pilih salah satu jenis kelamin"),
    new TextInputObject("No. Telp", "", validatePhoneNumber)
];
const state = reactive({
    errMsg: ""
});

function onSubmit(response:{[key:string]: string}){
    // TODO: Connect with backend
    console.log(response);
}
</script>

<template>
    <StatefulForm
        action="/login"
        method="post"
        :inputs="inputs"
        @submit="onSubmit"
    >
        <template v-slot:after>
            <p class="fw-light">Sudah ada akun? <a href="#" @click="$emit('changemode')">Login</a></p>
            <Alert :message="state.errMsg"/>
        </template>
    </StatefulForm>
</template>