import { defineStore } from "pinia";
import { MenuItem } from "./classes";
import { API } from "./constants";

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
			this.page = 0;
			this.searchTerm = "";
			if (this.isMenuInitialized){
				this.initFilterCategories();
				return;
			}

			const res = await fetch(API+"/menu/");
			if (res.ok){
				const json:any[] = await res.json();
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
		},
		remove(id: number){
			const idx = this.menu.findIndex(x => x.id == id);
			if (idx == -1) return;
			this.menu.splice(idx, 1);
		},
		add(item: MenuItem){
			this.menu.push(item);
		}
	}
});