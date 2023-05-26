<script setup lang="ts">
import { API, CONNECTION_ERROR } from '@/helpers/constants';
import { useRoute, useRouter } from 'vue-router';
import { useCurrentOrdersStore, useHistoryStore, usePageStateStore } from '../store';
import { useUserStore } from '../store';
import NavBar from '@/components/display/NavBar.vue';

const router = useRouter();
const pageState = usePageStateStore();
const currentOrders = useCurrentOrdersStore();
const history = useHistoryStore();
const user = useUserStore();
async function logout(){
    try {
    
    const res = await fetch(API+"/accounts/logout", {
        credentials: "include",
        method: "POST",
    });
    if (res.ok){
        currentOrders.cleanup();
        history.cleanup();
        user.logout();
        router.replace({name: "login"});
    }
    
    } catch (e) {
        pageState.setError(CONNECTION_ERROR)
    }
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