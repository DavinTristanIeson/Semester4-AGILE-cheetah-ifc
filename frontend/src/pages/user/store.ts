import { defineStore } from "pinia";
import { MenuTransaction, UserAccount } from "@/helpers/classes";
import { API } from "@/helpers/constants";

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
			const res = await fetch(API + "/accounts", {
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