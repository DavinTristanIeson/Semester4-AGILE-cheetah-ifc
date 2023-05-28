<script setup lang="ts">
import FetchWrapper from '@/components/function/FetchWrapper.vue';
import AccountForm from "./AccountForm.vue";
import { API } from '@/helpers/constants';
import { UserAccount } from '@/helpers/classes';
import { USER_KEY } from '@/helpers/keys';

async function initialize() {
    const res = await fetch(API + "/accounts", {
        credentials: "include"
    });
    if (!res.ok) throw res;
    const json = await res.json();
    return new UserAccount(json.id, json.email, json.name, json.gender, json.telp);
}
</script>
<template>
    <FetchWrapper :fn="initialize" :injectKey="USER_KEY">
        <AccountForm />
    </FetchWrapper>
</template>