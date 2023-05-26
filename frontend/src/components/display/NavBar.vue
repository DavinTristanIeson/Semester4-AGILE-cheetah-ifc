<script setup lang="ts">
import { useRoute, useRouter } from 'vue-router';

const props = defineProps<{
    brandDest: string;
    links: {
        name: string;
        dest?: string;
        action?: () => void;
    }[];
}>();
const route = useRoute();

</script>

<template>
    <nav class="navbar navbar-expand-lg fs-5">
    <div class="container-fluid">
        <RouterLink class="navbar-brand fs-2" :to="{ name: brandDest }">
            The Savory Spoon
        </RouterLink>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item" v-for="(link, idx) in links" :key="idx">
                    <RouterLink v-if="link.dest" class="nav-link" :class="{active: route.name == link.dest}" :to="{ name: link.dest }">{{ link.name }}</RouterLink>
                    <a v-else href="#" class="nav-link" @click="link.action">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
</template>