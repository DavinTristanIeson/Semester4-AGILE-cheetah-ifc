import { API } from '@/helpers/constants';
import { createRouter, createWebHistory } from 'vue-router'
import Home from "./views/Home.vue";

async function hasLogin(){
  try {
    const res = await fetch(API+"/accounts/me", {credentials: "include"});
    return res.ok && !(await res.json()).isAdmin;
  } catch (e){
    console.error(e);
    return false;
  }
}

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/login',
      name: 'login',
      async beforeEnter(to, from, next){
        if (await hasLogin()) next({name: "index"});
        else next();
      },
      component: () => import('./views/login/App.vue'),
    },
    {
      path: "/browse",
      name: 'browse',
      component: () => import("./views/browse/App.vue"),
    },
    {
      path: '/',
      name: "index",
      redirect: "/order",
      async beforeEnter(to, from, next){
        if (!(await hasLogin())) next({name: "login"});
        else next();
      },
      component: Home,
      children: [
        {
          path: "/order",
          name: "order",
          component: () => import("./views/order/App.vue")
        },
        {
          path: "/history",
          name: "history",
          component: () => import("./views/history/App.vue")
        },
        {
          path: "/account",
          name: "account",
          component: () => import("./views/account/App.vue")
        },
      ]
    }
  ]
});

export default router;