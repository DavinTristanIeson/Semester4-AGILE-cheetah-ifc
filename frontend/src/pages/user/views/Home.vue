<script setup lang="ts">
import { API, CONNECTION_ERROR } from '@/helpers/constants';
import { useRoute, useRouter } from 'vue-router';
import { usePageStateStore } from '../store';

const route = useRoute();
const router = useRouter();
const pageState = usePageStateStore();
async function logout(){
    // TODO: send request ke backend untuk logout
    try {
    
    const res = await fetch(API+"/accounts/logout", {
        credentials: "include",
        method: "POST",
    });
    if (res.ok){
        router.replace({name: "login"});
    }
    
    } catch (e) {
        pageState.setError(CONNECTION_ERROR)
    }
}
</script>

<template>
<nav class="navbar navbar-expand-lg fs-5">
    <div class="container-fluid">
        <RouterLink class="navbar-brand fs-2" to="/order">
            The Savory Spoon
        </RouterLink>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <RouterLink class="nav-link" :class="{active: route.name == 'order'}" to="/order">Pesan Makanan</RouterLink>
                </li>
                <li class="nav-item">
                    <RouterLink class="nav-link" :class="{active: route.name == 'history'}" to="/history">Sejarah Pesanan</RouterLink>
                </li>
                <li class="nav-item">
                    <RouterLink class="nav-link" :class="{active: route.name == 'account'}" to="/account">Akun Anda</RouterLink>
                </li>
                <li class="nav-item" @click="logout">
                    <a href="#" class="nav-link">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
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