import { MenuOrder, MenuTransaction, TransactionSummary } from "@/helpers/classes";
import { API } from "@/helpers/constants";
import { defineStore } from "pinia";

export const useOngoingOrdersStore = defineStore("ongoingOrders", {
  state: () => ({
    orders: [] as MenuTransaction[],
  }),
  getters: {
    chefMode(): { earliest: Date, order: MenuOrder }[] {
      const uniques: { [key: number]: { earliest: Date, order: MenuOrder } } = {};
      for (let ord of this.orders) {
        for (let item of ord.orders) {
          if (uniques.hasOwnProperty(item.id)) {
            uniques[item.id].order.quantity += item.quantity;
            uniques[item.id].order.note += '\n' + `(oleh: ${ord.username}) ${item.note}`;
            uniques[item.id].earliest = (uniques[item.id].earliest.getTime() <= ord.time.getTime() ? uniques[item.id].earliest : ord.time);
          } else {
            uniques[item.id] = {
              order: item.copy(),
              earliest: ord.time,
            };
            uniques[item.id].order.note = `(oleh: ${ord.username}) ${item.note}`;
          }
        }
      }
      const priorityList: { earliest: Date, order: MenuOrder }[] = [];
      for (let uniq in uniques) {
        priorityList.push(uniques[uniq]);
      }
      function isOverAnHour(time: Date) {
        return new Date().getTime() - time.getDate() > 1 * 60 * 60 * 1000;
      }

      priorityList.sort((a, b) => {
        const lateA = isOverAnHour(a.earliest);
        const lateB = isOverAnHour(b.earliest);
        if (lateA == lateB) return b.order.quantity - a.order.quantity;
        else if (lateA) return -1;
        else return 1;
      });

      return priorityList;
    }
  },
  actions: {
    async initialize() {
      const res = await fetch(API + "/orders/chef", {
        credentials: "include",
      });
      if (res.ok) {
        const json = await res.json();
        this.orders = MenuTransaction.fromJSONArray(json);
      }
    },
    addOrder(order: MenuTransaction) {
      this.orders.push(order);
    },
    removeOrder(order: MenuTransaction) {
      const idx = this.orders.indexOf(order);
      this.orders.splice(idx, 1);
    }
  },
});