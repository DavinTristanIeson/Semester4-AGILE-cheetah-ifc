<script setup lang="ts">
import { ref } from 'vue';

const props = defineProps<{
    semantic?:string,
}>();
const emit = defineEmits<{
    (e: "search", value:string): void,
}>();
const searchTerm = ref("");
function onPressEnter(event:KeyboardEvent){
    if (event.key != 'Enter') return;
    const target = event.target as HTMLInputElement;
    searchTerm.value = target.value;
    emit("search", searchTerm.value);
}
</script>

<template>
    <div class="my-3 ms-4 search-input">
        <input type="search"
            :value="searchTerm"
            @keypress="onPressEnter"
            :placeholder="semantic ?? 'Search'"/>
    </div>
</template>
<style>
.search-input {
    position: relative;
}
.search-input>input[type=search] {
    border: none; outline: none;
    background-color: #fff;
    padding: 10px 15px 10px 45px;
    border-radius: 30px;
    width: 100%;
    box-shadow: 0px 2px 4px 0.5px rgba(0,0,0,0.2);
}
.search-input:before {
    content: url("@/assets/search.svg");
    position: absolute;
    top: 0%; left: 0%;
    opacity: 0.3;
    transform: scale(60%, 60%);
}
</style>