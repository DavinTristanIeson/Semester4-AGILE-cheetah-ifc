<script setup lang="ts">
import LoginForm from './LoginForm.vue';
</script>

<template>
    <div id="login-brand-logo">
        <h2 class="m-0 p-0">The Savory Spoon</h2>
        <p class="m-0 p-0">Admin Dashboard</p>
        <div class="icon">
            <div></div>
            <div></div>
        </div>
    </div>
    
    <main>
        <LoginForm class="center-screen"/>
    </main>
</template>

<style>
#login-brand-logo {
    position: absolute;
    left: 50%;
    top: 15%;
    transform: translateX(-50%);
    font-family: "Josefin Sans";
    display: flex;
    flex-direction: column;
    align-items: center;
    color: white;
}
#login-brand-logo h2 {
    font-size: 72px;
}
#login-brand-logo .icon {
    display: flex;
}
#login-brand-logo .icon>div:first-of-type {
    border-radius: 50%;
    background-color: var(--secondary);
    width: 64px;
    height: 64px;
}
#login-brand-logo .icon>div:last-of-type {
    background-color: var(--secondary);
    width: 64px;
    height: 64px;
    margin-left: -5px;
    clip-path: polygon(100% 50%, 0 0, 0 100%);
}
</style>