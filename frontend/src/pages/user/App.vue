<script setup lang="ts">
import { RouterView } from 'vue-router';
import Spinner from '@/components/Spinner.vue';
import Alert from '@/components/Alert.vue';
import { reactive } from 'vue';

const state = reactive({
  isLoading: false,
  alertMsg: "",
  isSuccess: false,
  timeout: -1,
});
function handleAlert(message:string, isSuccess:boolean){
  state.alertMsg = message;
  state.isSuccess = isSuccess;
  clearTimeout(state.timeout)
  state.timeout = setTimeout(()=>{
    state.alertMsg = "";
  }, 3000);
}
function setLoading(isLoading:boolean){
  state.isLoading = isLoading;
}
</script>

<template>
  <Spinner :loading="state.isLoading"/>
  <RouterView
    @loading="setLoading"
    @error="handleAlert($event, false)"
    @success="handleAlert($event, true)"
  />
  <Alert
    :floating="true"
    :message="state.alertMsg"
    :success="state.isSuccess"
  />
</template>
