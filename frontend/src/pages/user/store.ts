import { defineStore } from "pinia";
import { MenuItem, MenuOrder, MenuTransaction, UserAccount } from "@/helpers/classes";
import { API } from "@/helpers/constants";

export const useCurrentOrdersStore = defineStore("currentOrders", {
	state: () => ({
		current: null as MenuTransaction | null,
		orders: [] as MenuOrder[],
		viewedOrder: undefined as (MenuOrder | undefined),
	}),
	getters: {
		totalPrice: state => state.orders.reduce((acc, cur) => acc + (cur.price * cur.quantity), 0),
		hargaTotal: state => MenuItem.toRupiah(state.orders.reduce((acc, cur) => acc + (cur.price * cur.quantity), 0)),
	},
	actions: {
		async initialize() {
			const res = await fetch(API + "/orders/ongoing", { credentials: "include" });
			if (res.ok) {
				const json = await res.json();
				this.current = MenuTransaction.fromJSON(json);
			}
		},
		addOrder(item: MenuItem) {
			let findme = this.orders.find(order => order.id == item.id);
			if (findme) findme.quantity++;
			else this.orders.push(new MenuOrder(item));
		},
		removeOrder(order: MenuOrder) {
			let idx = this.orders.indexOf(order);
			if (idx != -1) {
				this.orders.splice(idx, 1);
			}
		},
		examineOrder(order: MenuOrder | undefined) {
			this.viewedOrder = order;
		},
		async createTransaction() {
			this.viewedOrder = undefined;
			const res = await fetch(API + '/orders', {
				method: "POST",
				headers: {
					'Content-Type': "application/json",
				},
				credentials: "include",
				body: JSON.stringify(this.orders.map(x => ({
					name: x.name,
					price: x.price,
					quantity: x.quantity,
					note: x.note,
				})))
			});
			if (res.ok) {
				const json = await res.json();
				this.current = MenuTransaction.fromJSON(json);
				this.orders = [];
			}
		},
		finishTransaction() {
			this.current = null;
		},
		cancelTransaction(){
			if (!this.current) return;
			this.orders = this.current.orders;
			this.current = null;
		},
		cleanup() {
			this.current = null;
			this.orders = [];
		}
	}
});

export const useUserStore = defineStore("user", {
	state: () => ({
		user: null as (UserAccount | null),
	}),
	getters: {
		hasLogin: state => state.user !== null
	},
	actions: {
		async initialize() {
			if (this.user) return true;
			const res = await fetch(API + "/accounts/", {
				credentials: "include"
			});
			if (!res.ok) {
				return false;
			}
			const json = await res.json();
			this.user = new UserAccount(json.id, json.email, json.name, json.gender, json.telp);
			return true;
		},
		login(user: UserAccount) {
			this.user = user;
		},
		logout() {
			this.user = null;
		}
	}
});

const HISTORY_PER_PAGE = 10;
export const useHistoryStore = defineStore("history", {
	state: () => ({
		history: [] as MenuTransaction[],
		page: 0,
		isHistoryInitialized: false,
	}),
	getters: {
		current(state): MenuTransaction[] {
			return state.history.slice(state.page * HISTORY_PER_PAGE, state.page * HISTORY_PER_PAGE + HISTORY_PER_PAGE);
		},
		totalPages(state): number {
			return Math.floor(state.history.length / HISTORY_PER_PAGE);
		},
	},
	actions: {
		async initialize() {
			// fetch dari backend
			if (this.isHistoryInitialized) return;
			const res = await fetch(API + "/orders/history", {
				credentials: "include"
			});
			if (res.ok) {
				const json = await res.json();
				this.history = MenuTransaction.fromJSONArray(json);
				this.isHistoryInitialized = true;
			}
		},
		changePage(newPage: number) {
			this.page = Math.min(this.totalPages, Math.max(0, newPage));
		},
		cleanup() {
			this.isHistoryInitialized = false;
			this.history = [];
		}
	}
});