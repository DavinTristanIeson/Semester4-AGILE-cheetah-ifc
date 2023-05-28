<script setup lang="ts">
import { API, CONNECTION_ERROR, SERVER_ERROR } from '@/helpers/constants';
import { useRoute, useRouter } from 'vue-router';
import NavBar from '@/components/display/NavBar.vue';
import { PAGE_STATE_KEY } from '@/helpers/keys';
import { inject } from 'vue';

const router = useRouter();
const pageState = inject(PAGE_STATE_KEY)!;
async function logout(){
    pageState.run(async () => {
        const res = await fetch(API + "/accounts/logout", {
            method: "POST",
            credentials: "include"
        });
        if (res.ok) router.replace({name: "login"});
        else throw Error(SERVER_ERROR);
    });
}

const links = [
    {name: "Pesanan Sekarang", dest: "ongoing"},
    {name: "Rangkuman Transaksi", dest: "transactions"},
    {name: "Modifikasi Menu", dest: "menu"},
    {name: "Logout", action: logout},
]
</script>

<template>
<NavBar :links="links" brandDest="ongoing" />
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