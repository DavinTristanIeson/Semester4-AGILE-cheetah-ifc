import { defineStore } from "pinia";
import { UserAccount } from "@/helpers/classes";
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