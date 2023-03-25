import { createRouter, createWebHistory } from 'vue-router'
import Home from "./views/Home.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/login',
      name: 'login',
      async beforeEnter(to, from, next){
        // TODO: validasi apakah sudah login atau tidak
        next();
      },
      component: () => import('./views/login/App.vue'),
    },
    {
      path: '/',
      name: "index",
      redirect: "/order",
      async beforeEnter(to, from, next){
        // TODO: validasi apakah sudah login atau tidak
        next();
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