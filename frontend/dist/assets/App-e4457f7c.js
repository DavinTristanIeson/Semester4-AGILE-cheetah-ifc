import{d as m,o as s,b as l,n as t,x as c,F as i,y,c as d,u,a as p,E as _,i as f,w as g,A as x}from"./index-a9e6055c.js";import{_ as S,a as w}from"./Pagination.vue_vue_type_script_setup_true_lang-b254a2b2.js";import{_ as T}from"./OrderListItem.vue_vue_type_script_setup_true_lang-8ae4ca92.js";import{T as $,M as b}from"./classes-929a4aba.js";const j={class:"col-12 col-sm-6 col-md-4 col-lg-3 mx-2 transaction-summary"},A={class:"tss-bg-primary px-4 py-2 text-center fw-bold fs-3"},v={class:"tss-bg-secondary-dark p-3"},N={class:"mb-3"},R={class:"transaction-summary-stats"},k=t("th",null,"Total Pendapatan",-1),K=t("td",null,":",-1),P=t("th",null,"Pendapatan Rata-Rata",-1),B=t("td",null,":",-1),I=t("th",null,"Jumlah Pesanan",-1),V=t("td",null,":",-1),C=t("hr",null,null,-1),E={class:"list-group transaction-summary-list"},M=m({__name:"Summary",props:{summary:null},setup(a){return(r,o)=>(s(),l("div",j,[t("div",A,c(a.summary.dateString),1),t("div",v,[t("header",N,[t("table",R,[t("tr",null,[k,K,t("td",null,c(a.summary.hargaTotal),1)]),t("tr",null,[P,B,t("td",null,c(a.summary.hargaRata2),1)]),t("tr",null,[I,V,t("td",null,c(a.summary.count)+"x",1)])])]),C,t("ul",E,[(s(!0),l(i,null,y(a.summary.orders,n=>(s(),d(T,{item:n},null,8,["item"]))),256))])])]))}}),O={class:"horizontal-scroll mt-4 mb-3"},z=m({__name:"View",setup(a){const r=f(_);return(o,n)=>(s(),l(i,null,[t("div",O,[(s(!0),l(i,null,y(u(r).data,e=>(s(),d(M,{summary:e},null,8,["summary"]))),256))]),p(S,{injectKey:u(_)},null,8,["injectKey"])],64))}});const L=m({__name:"App",setup(a){async function r(o){const n=new URLSearchParams;n.append("page",o.toString());const e=await fetch(`${x}/orders/transactions?${n.toString()}`,{credentials:"include"});if(!e.ok)throw e;const h=await e.json();return{pages:h.pages,data:$.summarize(b.fromJSONArray(h.data))}}return(o,n)=>(s(),d(w,{fn:r,injectKey:u(_)},{default:g(()=>[p(z)]),_:1},8,["injectKey"]))}});export{L as default};