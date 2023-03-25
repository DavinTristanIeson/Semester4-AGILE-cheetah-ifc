import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    // {
    //   path: '/admin',
    //   name: 'A',
    //   component: () => import('../views/A.vue'),
    // },
  ]
});

export default router;