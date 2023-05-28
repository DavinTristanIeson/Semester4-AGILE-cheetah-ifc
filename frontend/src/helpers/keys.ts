import type { InjectionKey } from "vue";
import type { MenuItem, MenuOrder, MenuTransaction } from "./classes";

export interface PageState {
    loading: boolean;
    error: string;
    setError: (error: string, timeout?: number | null) => void;
    clear: () => void;
    run<T>(fn: () => Promise<T>): Promise<T | null>;
}
export const PAGE_STATE_KEY: InjectionKey<PageState> = Symbol("PageState");

export const FETCH_KEY: InjectionKey<unknown|null> = Symbol("Fetch");


export interface PaginationState<
    TData = unknown,
> {
    page: number;
    totalPages: number;
    data: TData[];
}
export interface PaginationProps<
    TData = unknown, 
    TParams = any
> extends PaginationState<TData> {
    setPage: (page: number, params?: TParams) => Promise<TData | null>;
    refetch: (params: TParams) => Promise<TData | null>;
}
export const PAGINATION_KEY: InjectionKey<PaginationProps> = Symbol("Pagination");

export interface MenuPaginationParams {
    search?: string;
    category?: string;
}
export type MenuPaginationProps = PaginationProps<MenuItem, MenuPaginationParams>;
export const MENU_PAGINATION_KEY: InjectionKey<MenuPaginationProps> = Symbol("Menu");
export const MENU_CATEGORIES_KEY: InjectionKey<string[]> = Symbol("Menu Categories");

export interface CurrentOrdersProps {
    current: MenuTransaction | null,
    orders: MenuOrder[],
    viewedOrder?: MenuOrder,

    add: (item: MenuItem) => void;
    remove: (order: MenuOrder) => void;
    examine: (order?: MenuOrder) => void;

    createTransaction: () => void;
    cancelTransaction: () => void;
    finishTransaction: () => void;
}
export const CURRENT_ORDERS_KEY: InjectionKey<CurrentOrdersProps> = Symbol("Current Orders");