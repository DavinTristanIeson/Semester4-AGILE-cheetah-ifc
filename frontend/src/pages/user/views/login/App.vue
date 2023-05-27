<script setup lang="ts">
import { reactive } from 'vue';
import LoginForm from "./LoginForm.vue";
import RegisterForm from "./RegisterForm.vue";
import Spinner from '@/components/display/Spinner.vue';

const emit = defineEmits<{
    (e:"loading", value:boolean): void,
    (e:"error", message:string, timeout:number|null): void
    (e:"success", message:string, timeout:number|null): void
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
                <div class="shadow-thick"></div>
                <div class="shadow-thick"></div>
            </div>
            <p class="shadow-thick">
                The Savory Spoon
            </p>
        </div>
        <div class="decoball" id="decoball-a">
            <img src="https://goldbelly.imgix.net/uploads/showcase_media_asset/image/126887/dry-aged-boneless-ribeye-steak-dinner-for-4.81c3bdc05fe6bdb2c2214709863120e0.jpg?ixlib=react-9.0.2&auto=format&ar=1%3A1" alt="Food Image #1"/>
        </div>
        <div class="decoball" id="decoball-b">
            <img src="https://goldbelly.imgix.net/uploads/showcase_media_asset/image/86731/memphis-pulled-pork-shoulder-4-lbs.089448f3aebd24fe82f223151314d853.jpg?ixlib=react-9.0.2&auto=format&ar=1%3A1" alt="Food Image #2"/>
        </div>
        <div class="decoball" id="decoball-c">
            <img src="https://goldbelly.imgix.net/uploads/showcase_media_asset/image/75464/carolina-pulled-pork-sandwich-pack.8e672a876d720c8471b08ffa47fbbbc1.jpg?ixlib=react-9.0.2&auto=format&ar=1%3A1" alt="Food Image #3"/>
        </div>
    </div>
    <main>
        <LoginForm v-if="state.isLogin" @changemode="changeMode" class="center-screen"/>
        <RegisterForm v-else @changemode="changeMode" class="center-screen"/>
    </main>
</template>

<style>
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
#tsvrspn-mark {
    background-image: url("https://goldbelly.imgix.net/uploads/showcase_media_asset/image/79619/joes-kc-ribs-brisket-and-burnt-ends.6710e994980e485e6441b794717ad6fb.jpg?ixlib=react-9.0.2&auto=format&ar=1%3A1");
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
}
.decoball {
    position: absolute;
    border-radius: 50%;
    background-color: var(--primary);
    padding: 0px;
    border: 6px solid black;
    overflow: hidden;
    transition: border-color 0.2s ease-out;
}
.decoball:hover {
    border-color: var(--dark);
}
.decoball img {
    border-radius: 50%;
    width: 100%;
    transition: transform 0.2s ease-out;
}
.decoball img:hover {
    transform: scale(105%, 105%);
    filter: brightness(110%);
}
#decoball-a {
    width: 30vw; height: 30vw;
    right: -10%; top: -10%;
    z-index: 3;
}
#decoball-b {
    width: 20vw; height: 20vw;
    left: -5%; bottom: -5%;
    z-index: 2;
}
#decoball-c {
    width: 10vw; height: 10vw;
    left: 20%; bottom: 25%;
    z-index: 0;
}
@media screen and (min-width: 1200px){
    .decoball {
        border: 12px solid black;
    }
    #decoball-a {
        width: 35vw; height: 35vw;
    }
    #decoball-b {
        width: 25vw; height: 25vw;
    }
    #decoball-c {
        width: 10vw; height: 10vw;
    }   
}
</style>