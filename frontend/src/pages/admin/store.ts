import { MenuItem, MenuOrder, MenuTransaction, TransactionSummary } from "@/helpers/classes";
import { defineStore } from "pinia";

export const useOngoingOrdersStore = defineStore("ongoingOrders", {
  state: ()=>({
    orders: [] as MenuTransaction[],
    areOrdersInitialized: false,
  }),
  getters: {
    chefMode(): {earliest:Date, order:MenuOrder}[] {
      const uniques:{[key:number]: {earliest:Date, order:MenuOrder}} = {};
      for (let ord of this.orders){
        for (let item of ord.orders){
          if (uniques.hasOwnProperty(item.id)){
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
      const priorityList:{earliest:Date, order:MenuOrder}[] = [];
      for (let uniq in uniques){
        priorityList.push(uniques[uniq]);
      }
      function isOverAnHour(time:Date){
        return new Date().getTime() - time.getDate() > 1*60*60*1000;
      }

      priorityList.sort((a, b)=>{
        const lateA = isOverAnHour(a.earliest);
        const lateB = isOverAnHour(b.earliest);
        if (lateA == lateB) return b.order.quantity - a.order.quantity;
        else if (lateA) return -1;
        else return 1;
      });
      console.log(priorityList);

      return priorityList;
    }
  },
  actions: {
    async initialize(){
      if (this.areOrdersInitialized) return;
      // TODO: fetch from backend
      this.orders = Array.from({length: 10}, (_, i) => {
        return new MenuTransaction(Math.random(), "Davin", new Date(), [
          new MenuOrder(new MenuItem(0, "a", "a", "a", "a", 1000), i, "Hallo"),
          new MenuOrder(new MenuItem(1, "a", "a", "a", "a", 1000), i, "Hallo"),
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
});

const TRANSACTIONS_PER_PAGE = 7;
export const useTransactionsStore = defineStore("transactions", {
  state: ()=>({
    transactions: [] as TransactionSummary[],
    page: 0,
    areTransactionsInitialized: false,
  }),
  getters: {
		current(state): TransactionSummary[] {
			return state.transactions.slice(state.page*TRANSACTIONS_PER_PAGE, state.page*TRANSACTIONS_PER_PAGE+TRANSACTIONS_PER_PAGE);
		},
		totalPages(state): number {
			return Math.floor(state.transactions.length / TRANSACTIONS_PER_PAGE);
		},
	},
  actions: {
    async initialize(){
      if (this.areTransactionsInitialized) return;

      const [startDate, endDate] = this.getDateRange();
      // TODO: fetch from backend
      this.transactions = Array.from({length:10}, (_, i) =>
        new TransactionSummary(
          Array.from({length: 10}, (_, i) =>
            new MenuTransaction(Math.random(), "Davin", new Date(), [
              new MenuOrder(new MenuItem(Math.random(), "a", "a", "a", "a", 1000), i, "Hallo"),
              new MenuOrder(new MenuItem(Math.random(), "a", "a", "a", "a", 1000), i, "Hallo"),
            ], "finished")
          ), new Date()
        )
      );
      this.areTransactionsInitialized = true;
    },
    getDateRange(): [Date, Date] {
      const SEVEN_DAYS = 7*24*60*60*1000
      const endDate = new Date(new Date().getTime() - (SEVEN_DAYS * this.page));
      const startDate = new Date(endDate.getTime() - SEVEN_DAYS);
      return [startDate, endDate];
    },
    changePage(newPage:number){
      this.page = newPage;
      const [startDate, endDate] = this.getDateRange();
      // fetch from backend
    }
  }
})