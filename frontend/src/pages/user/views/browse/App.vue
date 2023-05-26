<script setup lang="ts">
import { CONNECTION_ERROR, SERVER_ERROR } from '@/helpers/constants';
import { IntervalExecutor } from '@/helpers/requests';
import { onBeforeUnmount } from 'vue';
import { useMenuStore, usePageStateStore } from '../../store';
import MenuView from './MenuView.vue';

const menu = useMenuStore();

const pageState = usePageStateStore();
pageState.setLoading(true)
const executor = new IntervalExecutor(menu.initialize)
.on("success", ()=>{
    pageState.cleanup();
    if (!menu.isMenuInitialized){
        pageState.setError(SERVER_ERROR, 3000);
    }
}).on("failure", (e)=>{
    console.error(e);
    pageState.setLoading(false);
    pageState.setError(CONNECTION_ERROR)
});
executor.run();

onBeforeUnmount(()=>{
    executor.cleanup();
});
</script>

<template>
    <nav class="navbar navbar-expand-lg fs-5">
    <div class="container-fluid">
        <RouterLink class="navbar-brand fs-2" to="/browse">
            The Savory Spoon
        </RouterLink>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <RouterLink to="/login" class="nav-link">Login</RouterLink>
                </li>
            </ul>
        </div>
    </div>
    </nav>
    <MenuView/>
</template>
