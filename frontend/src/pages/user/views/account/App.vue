<script setup lang="ts">
import { API, CONNECTION_ERROR, SERVER_ERROR } from '@/helpers/constants';
import { TextInputObject } from '@/helpers/inputs';
import TextInput from '@/components/TextInput.vue';
import { IntervalExecutor } from '@/helpers/requests';
import { onBeforeUnmount, reactive } from 'vue';
import { useUserStore } from '../../store';
import { isNotEmpty } from '@/helpers/inputValidators';
import { useRouter } from 'vue-router';

const user = useUserStore();
const emit = defineEmits<{
    (e:"loading", value:boolean): void,
    (e:"error", message:string, timeout:number|null): void,
    (e:"success", message:string, timeout:number|null): void,
}>();
const state = reactive({
    requirePassword: false,
});

const router = useRouter();
const passwordInput = new TextInputObject("Password", "", isNotEmpty("Password harus diisi!"))

async function deleteAccount(){
    if (!state.requirePassword){
        state.requirePassword = true;
        return;
    }
    try {
        const res = await fetch(API+"/accounts/", {
            method: "DELETE",
            credentials: "include",
            headers: {
                'Content-Type': "application/json",
            },
            body: JSON.stringify({password: passwordInput.value}),
        });
        if (res.ok){
            user.logout();
            await fetch(API+"/accounts/logout", {
                method: "POST",
                credentials: "include",
            });
            router.replace({name: "login"});
        } else {
            const {message} = await res.json();
            emit("error", message, 3000);
        }
    } catch (e){
        console.error(e);
        emit("error", CONNECTION_ERROR, 3000);
    }
}

emit("loading", true);
const executor = new IntervalExecutor(user.initialize)
    .on("success", (result:boolean)=>{
        emit("loading", false)
        if (result) emit("error", "", null);
        else emit("error", SERVER_ERROR, 3000);
    }).on("failure", (e)=>{
        console.error(e);
        emit("error", CONNECTION_ERROR, null);
    });
executor.run();
onBeforeUnmount(()=>{
    executor.cleanup();
});
</script>

<template>
    <div class="tss-bg-secondary p-4 mt-5 rounded w-50 m-auto" v-if="!!user.user">
        <table class="account-detail-table mb-5">
            <tr>
                <td>Email</td>
                <td>:</td>
                <td>{{ user.user!.email }}</td>
            </tr>
            <tr>
                <td>Nama</td>
                <td>:</td>
                <td>{{ user.user!.name }}</td>
            </tr>
            <tr>
                <td>Jenis Kelamin</td>
                <td>:</td>
                <td>{{ user.user!.gender ? "Pria" : "Wanita" }}</td>
            </tr>
            <tr>
                <td>No. Telp</td>
                <td>:</td>
                <td>{{ user.user!.telp }}</td>
            </tr>
        </table>
        <TextInput :input="passwordInput" v-if="state.requirePassword"/>
        <button class="btn btn-danger w-100" @click="deleteAccount">Delete Akun</button>
    </div>
</template>

<style>
.account-detail-table tr>td:nth-child(1){
    font-weight: bold;
    font-size: 1.2em;
}
.account-detail-table tr>td:nth-child(2) {
    padding-left: 30px;
    padding-right: 50px;
}
</style>