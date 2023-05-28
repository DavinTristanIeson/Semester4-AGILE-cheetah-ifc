<script setup lang="ts">
import { useUserStore } from '../../store';
import FetchWrapper from '@/components/function/FetchWrapper.vue';
import AccountForm from "./AccountForm.vue";

const user = useUserStore();
</script>
<template>
    <FetchWrapper :fn="user.initialize">
        <AccountForm />
    </FetchWrapper>
</template>