<script setup lang="ts">
import StatefulForm from '@/components/input/StatefulForm.vue';
import { RadioInputObject, TextInputObject } from '@/helpers/inputs';
import { validateEmail, validateName, validatePassword, validatePhoneNumber } from "@/helpers/inputValidators"
import Alert from '@/components/display/Alert.vue';
import { reactive } from 'vue';
import { useRouter } from 'vue-router';
import { UserAccount } from '@/helpers/classes';
import { API, CONNECTION_ERROR } from '@/helpers/constants';

defineEmits<{
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
const router = useRouter();

async function onSubmit(response:{[key:string]: string}){
    try {
    const res = await fetch(API+"/accounts/register", {
        method: "POST",
        credentials: "include",
        headers: {
            'Content-Type': "application/json",
        },
        body: JSON.stringify({
            email: response["Email"],
            password: response["Password"],
            name: response["Nama"],
            gender: response["Jenis Kelamin"] == "male",
            telp: response["No. Telp"]
        })
    });
    if (!res.ok){
        state.errMsg = "Email sudah digunakan orang lain!";
    } else {
        router.replace({name: "index"});
    }

    } catch (e){
        console.error(e);
        state.errMsg = CONNECTION_ERROR;
    }
}
</script>

<template>
    <StatefulForm
        action="/login"
        method="post"
        :inputs="inputs"
        @submit="onSubmit"
        purpose="Daftar"
    >
        <template v-slot:after>
            <p class="fw-light">Sudah ada akun? <a href="#" @click="$emit('changemode')">Login</a></p>
            <Alert :message="state.errMsg"/>
        </template>
    </StatefulForm>
</template>