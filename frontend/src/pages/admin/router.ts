import { createRouter, createWebHistory } from 'vue-router'
import Home from './Home.vue';
import { API } from '@/helpers/constants';

async function hasLogin(){
  try {
    const res = await fetch(API+"/accounts/me", {credentials: "include"});
    return res.ok && (await res.json()).isAdmin;
  } catch (e){
    console.error(e);
    return false;
  }
}

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/admin/login',
      name: 'login',
      component: () => import('./views/login/App.vue'),
      async beforeEnter(req, res, next){
        if (await hasLogin()) next({name: "index"});
        else next();
      }
    },
    {
      path: '/admin',
      name: 'index',
      redirect: '/admin/ongoing',
      component: Home,
      async beforeEnter(req, res, next){
        if (await hasLogin()) next()
        else next({name: "login"});
      },
      children: [
        {
          path: "/admin/ongoing",
          name: "ongoing",
          component: () => import("./views/ongoing/App.vue")
        },
        {
          path: "/admin/transactions",
          name: "transactions",
          component: () => import("./views/transactions/App.vue")
        },
        {
          path: "/admin/menu",
          name: "menu",
          component: () => import("./views/menu/App.vue")
        }
      ]
    },
  ]
});

export default router;