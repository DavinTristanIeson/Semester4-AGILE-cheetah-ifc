<script setup lang="ts">
import { computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';

const route = useRoute();
const router = useRouter();
function logout(){
    // TODO: send request ke backend untuk logout
    router.replace({name: "login"});
}
</script>

<template>
<nav class="navbar navbar-expand-lg fs-5">
    <div class="container-fluid">
        <a class="navbar-brand fs-2" href="#">The Savory Spoon</a>
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

<style scoped>
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