<script setup lang="ts">
import MenuView from './MenuView.vue';
import NavBar from '@/components/display/NavBar.vue';
import MenuProvider from '@/components/function/MenuProvider.vue';
</script>

<template>
    <NavBar brandDest="login" :links="[{name: 'Login', dest: 'login'}]"/>
    <MenuProvider>
        <MenuView/>
    </MenuProvider>
</template>
