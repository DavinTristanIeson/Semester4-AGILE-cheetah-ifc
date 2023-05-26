<script setup lang="ts">
import StatefulForm from '@/components/input/StatefulForm.vue';
import { TextInputObject } from '@/helpers/inputs';
import Alert from '@/components/display/Alert.vue';
import { reactive } from 'vue';
import { useRouter } from 'vue-router';
import { API, CONNECTION_ERROR } from '@/helpers/constants';

defineEmits<{
    (e:"changemode"): void
}>();

const inputs = [
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

    const res = await fetch(API + "/accounts/login/admin", {
        method: "POST",
        credentials: "include",
        headers: {
            'Content-Type': "application/json"
        },
        body: JSON.stringify({password: response["Password"]}),
    });

    if (res.ok){
        router.replace({name: 'index'});
    } else {
        state.errMsg = "Password salah";
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
        <Alert :message="state.errMsg"/>
    </template>
    </StatefulForm>
</template>