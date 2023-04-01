import { createRouter, createWebHistory } from 'vue-router'
import Home from './Home.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/admin/login',
      name: 'login',
      component: () => import('./views/login/App.vue'),
    },
    {
      path: '/admin',
      name: 'index',
      redirect: '/admin/ongoing',
      component: Home,
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
        }
      ]
    },
  ]
});

export default router;