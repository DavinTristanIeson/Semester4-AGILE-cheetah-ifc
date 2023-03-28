import { defineStore } from "pinia";
import { MenuItem, MenuOrder, UserAccount } from "@/helpers/classes";
import { API } from "@/helpers/constants";

export const useCurrentOrdersStore = defineStore("currentOrders", {
	state: () => ({
		orders: [] as MenuOrder[],
		viewedOrder: undefined as (MenuOrder | undefined),
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
		},
		examineOrder(order:MenuOrder|undefined){
			this.viewedOrder = order;
		}
	}
});

const MENU_PER_PAGE = 20;
export const useMenuStore = defineStore("menu", {
	state: ()=>({
		menu: [] as MenuItem[],
		page: 0,
		isMenuInitialized: false,
		searchTerm: "",
		filterCategories: [] as string[],
	}),
	getters: {
		allCategories(state): string[] {
			let categories:string[] = [];
			for (let item of state.menu){
				if (categories.includes(item.category)) continue
				else categories.push(item.category);
			}
			return categories;
		},
		filteredMenuByCategory(state): MenuItem[] {
			// Two-stage filter operation, so that part of the filtered menu can be cached
			return state.menu.filter(item => state.filterCategories.includes(item.category));
		},
		filteredMenu(state): MenuItem[] {
			return this.filteredMenuByCategory.filter(item => item.name.startsWith(state.searchTerm));
		},
		current(state): MenuItem[] {
			return this.filteredMenu.slice(state.page*MENU_PER_PAGE, state.page*MENU_PER_PAGE+MENU_PER_PAGE);
		},
		totalPages(state): number {
			return Math.floor(this.filteredMenu.length / MENU_PER_PAGE);
		}
	},
	actions: {
		async initialize(){
			// TODO: fetch menu data from backend
			this.page = 0;
			this.searchTerm = "";
			if (this.isMenuInitialized){
				this.initFilterCategories();
				return;
			}

			const res = await fetch(API+"/menu/");
			if (res.ok){
				const json:any[] = await res.json()
				this.menu = json.map(x => new MenuItem(x.id, x.name, x.category, x.description, x.img, x.price));
				this.isMenuInitialized = true;
				this.initFilterCategories();
			}
			
		},
		initFilterCategories(){
			if (!this.isMenuInitialized) return;
			for (let item of this.menu){
				if (this.filterCategories.includes(item.category)) continue
				else this.filterCategories.push(item.category);
			}
		},
		changePage(newPage:number){
			this.page = Math.min(this.totalPages, Math.max(0, newPage));
		}
	}
});

export const useUserStore = defineStore("user", {
	state: ()=>({
		user: null as (UserAccount|null),
	}),
	getters: {
		hasLogin: state => state.user !== null
	},
	actions: {
		login(user:UserAccount){
			this.user = user;
		},
		logout(){
			this.user = null;
		}
	}
})