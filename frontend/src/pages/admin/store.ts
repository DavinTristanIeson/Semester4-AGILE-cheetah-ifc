import { MenuItem, MenuOrder, MenuTransaction } from "@/helpers/classes";
import { defineStore } from "pinia";

export const useOngoingOrdersStore = defineStore("ongoingOrders", {
  state: ()=>({
    orders: [] as MenuTransaction[],
    areOrdersInitialized: false,
  }),
  actions: {
    async initialize(){
      if (this.areOrdersInitialized) return;
      // TODO: fetch from backend
      this.orders = Array.from({length: 10}, (_, i) => {
        return new MenuTransaction(Math.random(), "Davin", new Date(), [
          new MenuOrder(new MenuItem(Math.random(), "a", "a", "a", "a", 1000), i, "Hallo"),
          new MenuOrder(new MenuItem(Math.random(), "a", "a", "a", "a", 1000), i, "Hallo"),
        ], "pending");
      });
      this.areOrdersInitialized = true;
    },
    addOrder(order: MenuTransaction){
      this.orders.push(order);
    },
    removeOrder(order: MenuTransaction){
      const idx = this.orders.indexOf(order);
      this.orders.splice(idx, 1);
    }
  },
})