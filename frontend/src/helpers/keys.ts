import type { InjectionKey, Ref, ComputedRef } from "vue";
import type { MenuItem, MenuOrder, MenuTransaction, TransactionSummary, UserAccount } from "./classes";

export interface PageState {
    loading: boolean;
    error: string;
    setError: (error: string, timeout?: number | null) => void;
    clear: () => void;
    run<T>(fn: () => Promise<T>): Promise<T | null>;
}
export type FetchProps<T> = Ref<T|null>;
export const PAGE_STATE_KEY: InjectionKey<PageState> = Symbol("PageState");

export const FETCH_KEY: InjectionKey<Ref<unknown>> = Symbol("Fetch");


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
export const MENU_CATEGORIES_KEY: InjectionKey<FetchProps<string[]>> = Symbol("Menu Categories");

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

export const TRANSACTION_HISTORY_KEY: InjectionKey<PaginationProps<MenuTransaction, never>> = Symbol("Transaction History");
export const ADMIN_TRANSACTION_HISTORY_KEY:  InjectionKey<PaginationProps<TransactionSummary, never>> = Symbol("Admin Transaction History");

export const USER_KEY: InjectionKey<FetchProps<UserAccount>> = Symbol();

interface OngoingOrdersProps {
    data: MenuTransaction[];
    add: (order: MenuTransaction) => void;
    remove: (order: MenuTransaction) => void;
}
export const ONGOING_ORDERS_KEY: InjectionKey<OngoingOrdersProps> = Symbol("Ongoing Orders");

export type ChefModeProps = ComputedRef<{
    earliest: Date;
    order: MenuOrder;
}[]>;
export const CHEF_MODE_KEY: InjectionKey<ChefModeProps> = Symbol("Chef Mode");