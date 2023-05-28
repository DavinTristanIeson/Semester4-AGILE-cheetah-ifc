<script setup lang="ts">
import { API, SERVER_ERROR } from '@/helpers/constants';
import { useRouter } from 'vue-router';
import NavBar from '@/components/display/NavBar.vue';
import { PAGE_STATE_KEY } from '@/helpers/keys';
import { inject } from 'vue';

const router = useRouter();
const pageState = inject(PAGE_STATE_KEY)!;
async function logout(){
    pageState.run(async () => {
        const res = await fetch(API+"/accounts/logout", {
            credentials: "include",
            method: "POST",
        });
        if (res.ok){
            router.replace({name: "login"});
        } else {
            throw new Error(SERVER_ERROR);
        }
    });
}
const links = [
    {name: "Pesan Makanan", dest: "order"},
    {name: "Sejarah Pesanan", dest: "history"},
    {name: "Akun Anda", dest: "account"},
    {name: "Logout", action: logout}
];
</script>

<template>
<NavBar brandDest="order" :links="links"/>
<RouterView/>
</template>

<style>
nav {
    background-color: var(--dark);
    border-bottom-left-radius: 20px;
    border-bottom-right-radius: 20px;
    padding: 20px 10px;
}
.navbar-brand {
    font-family: "Josefin Sans";
}
</style>