<script setup lang="ts">
import { RouterView } from 'vue-router';
import Spinner from '@/components/display/Spinner.vue';
import Alert from '@/components/display/Alert.vue';
import { usePageStateStore } from './store';
const state = usePageStateStore();
</script>

<template>
  <Spinner :loading="state.isLoading"/>
  <RouterView/>
  <Alert
    :floating="true"
    :message="state.errorMessage"
    @click="state.clearError"
  />
</template>
