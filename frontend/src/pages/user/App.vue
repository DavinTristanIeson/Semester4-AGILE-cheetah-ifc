<script setup lang="ts">
import { RouterView } from 'vue-router';
import Spinner from '@/components/Spinner.vue';
import Alert from '@/components/Alert.vue';
import { reactive } from 'vue';

const state = reactive({
  isLoading: false,
  alertMsg: "",
  isSuccess: false,
});
function handleAlert(message:string, isSuccess:boolean){
  state.alertMsg = message;
  state.isSuccess = isSuccess;
}
</script>

<template>
  <Spinner :loading="state.isLoading"/>
  <RouterView
    @loading="state.isLoading = true"
    @error="handleAlert($event, false)"
    @success="handleAlert($event, true)"
  />
  <Alert
    :floating="true"
    :message="state.alertMsg"
    :success="state.isSuccess"
  />
</template>
