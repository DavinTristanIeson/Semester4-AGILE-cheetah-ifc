import type { InjectionKey } from "vue";

export interface PageState {
    loading: boolean;
    error: string;
    setError: (error: string, timeout?: number | null) => void;
    clear: () => void;
    run<T>(fn: () => Promise<T>): Promise<T | null>;
}
export const PAGE_STATE_KEY: InjectionKey<PageState> = Symbol("PageState");

export const FETCH_DEFAULT_KEY: InjectionKey<unknown> = Symbol("Default Fetch");