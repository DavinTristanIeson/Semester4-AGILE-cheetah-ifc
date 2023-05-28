<script setup lang="ts">
import StatefulForm from '@/components/input/StatefulForm.vue';
import { TextInputObject } from '@/helpers/inputs';
import Alert from '@/components/display/Alert.vue';
import { reactive } from 'vue';
import { useRouter } from 'vue-router';
import { API, CONNECTION_ERROR } from '@/helpers/constants';
import { UserAccount } from '@/helpers/classes';

defineEmits<{
    (e:"changemode"): void
}>();

const inputs = [
    new TextInputObject("Email", "", email => email.length == 0 ? "Email harus diisi" : "", {
        semanticType: "email"
    }),
    new TextInputObject("Password", "", password => password.length == 0 ? "Password harus diisi" : "", {
        semanticType: "password"
    }),
];

const state = reactive({
    errMsg: ""
});
const router = useRouter();

async function onSubmit(response:{[key:string]: string}){
    try {

    const res = await fetch(API+"/accounts/login", {
        method: "POST",
        credentials: "include",
        headers: {
            'Content-Type': "application/json",
        },
        body: JSON.stringify({
            email: response["Email"],
            password: response["Password"]
        })
    });
    if (!res.ok){
        state.errMsg = "Email atau password salah!";
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
        purpose="Login"
    >
    <template v-slot:after>
        <p class="fw-light">Belum ada akun? <a href="#" @click="$emit('changemode')">Daftar</a></p>
        <Alert :message="state.errMsg"/>
    </template>
    </StatefulForm>
</template>