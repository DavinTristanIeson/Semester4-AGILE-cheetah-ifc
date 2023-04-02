import { MenuItem, MenuOrder, MenuTransaction, TransactionSummary } from "@/helpers/classes";
import { API } from "@/helpers/constants";
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
      const res = await fetch(API + "/orders/chef", {
        credentials: "include",
      });
      if (res.ok){
        const json = await res.json();
        console.log(json);
        this.orders = MenuTransaction.fromJSON(json);
        this.areOrdersInitialized = true;
      }
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
      const res = await fetch(API + `/orders/transactions?start=${startDate.toISOString()}&end=${endDate.toISOString()}`, {
        credentials: "include",
      });
      if (res.ok){
        const json = await res.json();
        console.log(json);
        const rawTransactions = MenuTransaction.fromJSON(json);
        this.transactions = TransactionSummary.summarize(rawTransactions);
        this.areTransactionsInitialized = true;
      }
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
    },
    addNewTransaction(transaction:MenuTransaction){
      function isSameDay(x: TransactionSummary){
        console.log(x.date.getDate(), transaction.time.getDate(), x.date.getMonth(), transaction.time.getMonth(), x.date.getFullYear(), transaction.time.getFullYear());
        return x.date.getDate() == transaction.time.getDate() && x.date.getMonth() == transaction.time.getMonth() && x.date.getFullYear() == transaction.time.getFullYear()
      }
      const summary = this.transactions.find(isSameDay);
      console.log(summary);
      if (!summary) return;
      summary.append(transaction);
    }
  }
})