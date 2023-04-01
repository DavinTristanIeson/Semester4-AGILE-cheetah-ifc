<script setup lang="ts">
import { API, CONNECTION_ERROR } from '@/helpers/constants';
import { useRoute, useRouter } from 'vue-router';

const emit = defineEmits<{
    (e:"loading", value:boolean): void,
    (e:"error", value:string, timeout:number|null): void,
    (e:"success", value:string, timeout:number|null): void,
}>();

const route = useRoute();
const router = useRouter();
async function logout(){
    // TODO: send request ke backend untuk logout
    try {
    
    router.replace({name: "login"});
    
    } catch (e) {
        emit("error", CONNECTION_ERROR, null);
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
                    <RouterLink class="nav-link" :class="{active: route.name == 'ongoing'}" to="/admin/ongoing">Pesanan Sekarang</RouterLink>
                </li>
                <li class="nav-item">
                    <RouterLink class="nav-link" :class="{active: route.name == 'transactions'}" to="/admin/transactions">Rangkuman Transaksi</RouterLink>
                </li>
                <li class="nav-item" @click="logout">
                    <a href="#" class="nav-link">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<RouterView
    @loading="$emit('loading', $event)"
    @error="$emit('error', $event)"
    @success="$emit('success', $event)"
/>
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