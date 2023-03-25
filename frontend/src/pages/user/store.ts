import { defineStore } from "pinia";
import { MenuItem, MenuOrder } from "@/helpers/classes";

export const useCurrentOrdersStore = defineStore("currentOrders", {
	state: () => ({
		orders: [] as MenuOrder[],
	}),
	getters: {
		totalPrice: state => state.orders.reduce((acc, cur) => acc + (cur.price * cur.quantity), 0),
		hargaTotal: state => MenuItem.toRupiah(state.orders.reduce((acc, cur) => acc + (cur.price * cur.quantity), 0)),
	},
	actions: {
		addOrder(item:MenuItem){
			let findme = this.orders.find(order => order.id == item.id);
			if (findme) findme.quantity++;
			else this.orders.push(new MenuOrder(item));
		},
		removeOrder(order:MenuOrder){
			let idx = this.orders.indexOf(order);
			if (idx != -1){
				this.orders.splice(idx, 1);
			}
		}
	}
});

const MENU_PER_PAGE = 25;
export const useMenuStore = defineStore("menu", {
	state: ()=>({
		menu: [] as MenuItem[],
		page: 0,
		isMenuInitialized: false
	}),
	getters: {
		currentPage: (state) => state.menu.slice(state.page*MENU_PER_PAGE, state.page*MENU_PER_PAGE+MENU_PER_PAGE),
		totalPages: (state) => Math.ceil(state.menu.length / MENU_PER_PAGE)
	},
	actions: {
		async initialize(){
			// TODO: fetch menu data from backend
		},
		changePage(newPage:number){
			this.page = Math.min(this.totalPages, Math.max(0, newPage));
		}
	}
})