export function timeout(millis:number){
    return new Promise((resolve, reject)=>{
        setTimeout(resolve, millis);
    })
}

export class IntervalExecutor<T> {
    private timeoutID?:number;
    private fn:()=>Promise<T | Error>;
    private onSuccess?:(payload:T)=>void;
    private onFailure?:(e:unknown)=>void;
    readonly interval:number;
    finished:boolean;
    constructor(fn:()=>Promise<T>, interval:number=3000){
        this.fn = fn;
        this.interval = interval;
        this.finished = false;
    }
    on(event:"success", fn:(payload:T)=>void): IntervalExecutor<T>;
    on(event:"failure", fn:(e:unknown)=>void): IntervalExecutor<T>;
    on(event:"success"|"failure", fn:(value:any)=>void): IntervalExecutor<T> {
        if (event == "failure") this.onFailure = fn;
        else if (event == "success") this.onSuccess = fn;
        return this;
    }
    run(){
        this.finished = false;
        return new Promise<void>(async (resolve, reject)=>{
            while (!this.finished){
                try {
                    let response:T | Error= await this.fn();
                    if (response instanceof Error){
                        this.onFailure?.(response);
                        this.finished = true;
                        reject(response);
                    } else {
                        this.onSuccess?.(response);
                        this.finished = true;
                        resolve();
                    }
                } catch (e) {
                    this.onFailure?.(e);
                    await timeout(this.interval);
                }
            }
        });
    }
    cleanup(){
        clearTimeout(this.timeoutID);
        this.finished = true;
    }
}

// https://stackoverflow.com/questions/71466297/how-to-use-vue-3-socket-io-with-composition-api-in-vue-js
import { io } from "socket.io-client";
import { BACKEND } from "./constants";
export const socket = io(BACKEND, {withCredentials: true, transports: ['websocket', 'polling', 'flashsocket']});

export interface PaginatedApiResult<T = object> {
    pages: number;
    data: T[];
}