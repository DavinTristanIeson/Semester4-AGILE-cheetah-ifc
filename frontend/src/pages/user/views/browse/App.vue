<script setup lang="ts">
import { useMenuStore } from '@/helpers/menuStore';
import MenuView from './MenuView.vue';
import NavBar from '@/components/display/NavBar.vue';
import FetchWrapper from '@/components/function/FetchWrapper.vue';

const menu = useMenuStore();
</script>

<template>
    <NavBar brandDest="login" :links="[{name: 'Login', dest: 'login'}]"/>
    <FetchWrapper :fn="menu.initialize" floating>
        <MenuView/>
    </FetchWrapper>
</template>
