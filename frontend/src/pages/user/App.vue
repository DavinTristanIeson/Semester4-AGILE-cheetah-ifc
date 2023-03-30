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
function handleAlert(message:string, timeout:number|null, isSuccess:boolean){
  state.alertMsg = message;
  state.isSuccess = isSuccess;
  clearTimeout(state.timeout);
  if (timeout == null) return;
  state.timeout = setTimeout(()=>{
    state.alertMsg = "";
  }, timeout);
}
function setLoading(isLoading:boolean){
  state.isLoading = isLoading;
}
</script>

<template>
  <Spinner :loading="state.isLoading"/>
  <RouterView
    @loading="setLoading"
    @error="(msg:string, timeout:number) => handleAlert(msg, timeout, false)"
    @success="(msg:string, timeout:number) => handleAlert(msg, timeout, true)"
  />
  <Alert
    :floating="true"
    :message="state.alertMsg"
    :success="state.isSuccess"
    @click="state.alertMsg=''"
  />
</template>
