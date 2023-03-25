<script setup lang="ts">
import StatefulForm from '@/components/StatefulForm.vue';
import { TextInputObject } from '@/helpers/inputs';
import Alert from '@/components/Alert.vue';
import { reactive } from 'vue';
import { useRouter } from 'vue-router';

const emit = defineEmits<{
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

function onSubmit(response:{[key:string]: string}){
    // TODO: Connect with backend
    console.log(response);
    router.replace({name: "index"});
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
        <p class="fw-light">Belum ada akun? <a href="#" @click="$emit('changemode')">Daftar</a></p>
        <Alert :message="state.errMsg"/>
    </template>
    </StatefulForm>
</template>