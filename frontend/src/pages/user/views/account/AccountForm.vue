<script setup lang="ts">
import { API, SERVER_ERROR } from '@/helpers/constants';
import { RadioInputObject, TextInputObject } from '@/helpers/inputs';
import TextInput from '@/components/input/TextInput.vue';
import { inject, onBeforeUnmount, reactive } from 'vue';
import { isNotEmpty, validateEmail, validateName, validatePassword, validatePhoneNumber } from '@/helpers/inputValidators';
import { useRouter } from 'vue-router';
import { PAGE_STATE_KEY, USER_KEY } from '@/helpers/keys';
import StatefulForm from '@/components/input/StatefulForm.vue';
import Alert from '@/components/display/Alert.vue';

const user = inject(USER_KEY)!;
const pageState = inject(PAGE_STATE_KEY)!;

const state = reactive({
    requirePassword: false,
    success: "",
    successTimeout: -1,
});

const router = useRouter();

function validateNewPassword(password: string){
    return password.length > 0 ? validatePassword(password) : "";
}

const inputs = [
    new TextInputObject("Email", user.value!.email ?? "", validateEmail, {semanticType: 'email'}),
    new TextInputObject("Password Baru", "", validateNewPassword, {semanticType: 'password'}),
    new TextInputObject("Nama", user.value!.name ?? "", validateName),
    new RadioInputObject("Jenis Kelamin", user.value!.gender ? "male" : "female", [
        { label: "Pria", value:"male" },
        { label: "Wanita", value:"female" }
    ], "Pilih salah satu jenis kelamin"),
    new TextInputObject("No. Telp", user.value!.telp ?? "", validatePhoneNumber),
]
const passwordInput = new TextInputObject("Password", "", isNotEmpty("Password harus diisi!"), {semanticType: 'password'});

function editAccount(payload: any){
    const needPassword = payload["Password Baru"].length > 0;
    if (needPassword && !state.requirePassword){
        state.requirePassword = true;
        return;
    }
    if (needPassword && passwordInput.value.length == 0) {
        return;
    }
    pageState.run(async () => {
        const sent: {
            [key:string]: any
        } = {
            email: payload["Email"],
            password: payload["Password Baru"],
            name: payload["Nama"],
            gender: payload["Jenis Kelamin"] == "male",
            telp: payload["No. Telp"],
        }
        if (needPassword){
            sent["verify"] = passwordInput.value;
        }
        const res = await fetch(`${API}/accounts`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(sent),
            credentials: "include",
        });
        if (!res.ok){
            let message = SERVER_ERROR;
            try {
                const raw = await res.json();
                message = raw.message;
            } catch (e){
                console.error(e);
            }
            throw new Error(message);
        }
        
        state.success = "Sukses mengubah informasi akun";
        clearTimeout(state.successTimeout);
        state.successTimeout = setTimeout(() => {
            state.success = "";
        }, 3000);
        state.requirePassword = false;
        inputs[1].error = "";
        inputs[1].value = "";
        
        user.value!.email = sent.email;
        user.value!.name = sent.name;
        user.value!.gender = sent.gender;
        user.value!.telp = sent.telp;
    });
}

async function deleteAccount(){
    if (!state.requirePassword){
        state.requirePassword = true;
        return;
    }
    if (passwordInput.value.length == 0) {
        return;
    }
    pageState.run(async () => {
        const res = await fetch(API+"/accounts", {
            method: "DELETE",
            credentials: "include",
            headers: {
                'Content-Type': "application/json",
            },
            body: JSON.stringify({password: passwordInput.value}),
        });
        if (res.ok){
            await fetch(API+"/accounts/logout", {
                method: "POST",
                credentials: "include",
            });
            router.replace({name: "login"});
        } else {
            const {message} = await res.json();
            throw new Error(message);
        }
    })
}

onBeforeUnmount(() => {
    clearTimeout(state.successTimeout);
});
</script>

<template>
    <StatefulForm class="center-screen"
        @submit="editAccount"
        action="#" method="put"
        :inputs="inputs" purpose="Simpan"
        validateFromStart>
        <template v-slot:after>
            <Alert success :message="state.success" />
        </template>
        <template v-slot:footer>
            <div class="mt-4 my-2">
                <TextInput :input="passwordInput" v-if="state.requirePassword" shouldValidate/>
                <button class="btn btn-danger w-100 fs-5" @click.prevent="deleteAccount">Delete Akun</button>
            </div>
        </template>
    </StatefulForm>
</template>