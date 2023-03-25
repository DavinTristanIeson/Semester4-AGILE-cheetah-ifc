import { defineStore } from "pinia";
import { type MenuItem, MenuOrder } from "@/helpers/classes";

export const useCurrentOrdersStore = defineStore("currentOrders", {
	state: () => ({
		orders: [] as MenuOrder[],
	}),
	getters: {
		totalPrice: state => state.orders.reduce((acc, cur) => acc + cur.price, 0),
	},
	actions: {
		addOrder(item:MenuItem){
			let findme = this.orders.find(order => order.id == item.id);
			if (findme) findme.quantity++;
			else this.orders.push(new MenuOrder(item));
		}
	}
});

export const useMenuStore = defineStore("menu", {
	state: ()=>({
		menu: [] as MenuItem[],
		isMenuInitialized: false
	}),
	actions: {
		async initialize(){
			// TODO: fetch menu data from backend
		}
	}
})