<script setup lang="ts">
import { reactive } from 'vue';
import LoginForm from "./LoginForm.vue";
import RegisterForm from "./RegisterForm.vue";
import Spinner from '@/components/Spinner.vue';

const emit = defineEmits<{
    (e:"loading", value:boolean): void,
    (e:"error", value:string): void,
    (e:"success", value:string): void,
}>();

const state = reactive({
    isLogin: true,
})
function changeMode(){
    state.isLogin = !state.isLogin;
}
</script>

<template>
    <div class="hide-overflow position-relative vh-100">
        <div id="tsvrspn-mark">
            <div id="tsvrspn-icon">
                <div></div>
                <div></div>
            </div>
            <p>
                The Savory Spoon
            </p>
        </div>
        <div class="decoball" id="decoball-a"></div>
        <div class="decoball" id="decoball-b"></div>
        <div class="decoball" id="decoball-c"></div>
    </div>
    <main>
        <LoginForm v-if="state.isLogin" @changemode="changeMode" class="center-screen"/>
        <RegisterForm v-else @changemode="changeMode" class="center-screen"/>
    </main>
</template>

<style scoped>
#tsvrspn-icon>div:nth-child(1) {
    border-radius: 50%;
    background-color: var(--secondary);
    width: 60px;
    height: 60px;
    position: absolute;
    top: 20%;
    left: 5%;
}
#tsvrspn-icon>div:nth-child(2) {
    background-color: var(--secondary);
    width: 60px;
    height: 60px;
    position: absolute;
    clip-path: polygon(100% 50%, 0 0, 0 100%);
    top: 20%;
    left: 14%;
}
#tsvrspn-mark {
    position: absolute;
    top: 0%;
    left: 0%;
    padding: 100px 150px 200px 100px;
    background-color: var(--primary);
    clip-path: polygon(100% 0, 0 0, 0 100%);
}
#tsvrspn-mark p {
    font-family: "Josefin Sans";
    font-weight: bold;
    font-size: 48px;
    transform: rotate(-30deg);
    color: white;
}
.decoball {
    position: absolute;
    border-radius: 50%;
    background-color: var(--primary);
}
#decoball-a {
    width: 35vw; height: 35vw;
    right: -10%; top: -10%;
    z-index: 3;
}
#decoball-b {
    width: 25vw; height: 25vw;
    left: -5%; bottom: -5%;
    z-index: 2;
}
#decoball-c {
    width: 15vw; height: 15vw;
    left: 20%; bottom: 25%;
    z-index: -1;
}
</style>