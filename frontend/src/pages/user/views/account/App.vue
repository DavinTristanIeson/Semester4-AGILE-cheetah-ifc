<script setup lang="ts">
import { API, CONNECTION_ERROR, SERVER_ERROR } from '@/helpers/constants';
import { TextInputObject } from '@/helpers/inputs';
import TextInput from '@/components/input/TextInput.vue';
import { IntervalExecutor } from '@/helpers/requests';
import { inject, onBeforeUnmount, reactive } from 'vue';
import { useUserStore } from '../../store';
import { isNotEmpty } from '@/helpers/inputValidators';
import { useRouter } from 'vue-router';
import { PAGE_STATE_KEY } from '@/components/function/keys';
import FetchWrapper from '@/components/function/FetchWrapper.vue';

const user = useUserStore();
const state = reactive({
    requirePassword: false,
});

const router = useRouter();
const passwordInput = new TextInputObject("Password", "", isNotEmpty("Password harus diisi!"));
const pageState = inject(PAGE_STATE_KEY)!;

async function deleteAccount(){
    if (!state.requirePassword){
        state.requirePassword = true;
        return;
    }
    pageState.run(async () => {
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
            pageState.setError(message, 3000);
        }
    })
}
</script>
<template>
    <FetchWrapper :fn="user.initialize">
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
    </FetchWrapper>
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