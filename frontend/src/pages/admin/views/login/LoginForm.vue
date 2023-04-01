<script setup lang="ts">
import StatefulForm from '@/components/StatefulForm.vue';
import { TextInputObject } from '@/helpers/inputs';
import Alert from '@/components/Alert.vue';
import { reactive } from 'vue';
import { useRouter } from 'vue-router';
import { API, CONNECTION_ERROR } from '@/helpers/constants';
import { UserAccount } from '@/helpers/classes';

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

    // TODO: connect ke backend
    router.replace({name: 'index'});

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
    </StatefulForm>
</template>