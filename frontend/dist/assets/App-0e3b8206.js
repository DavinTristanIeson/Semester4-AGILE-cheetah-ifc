import{I as h}from"./requests-89d0a4b8.js";import{a as p,b as y}from"./admin-4ceaaea6.js";import{_ as f}from"./OrderListItem.vue_vue_type_script_setup_true_lang-f2209271.js";import{a as u,o as n,c as l,f as t,D as r,F as i,E as m,v as _,S as g,C as R,y as x,u as E}from"./index-13c58849.js";const S={class:"col-12 col-sm-6 col-md-4 col-lg-3 mx-2 transaction-summary"},v={class:"tss-bg-primary px-4 py-2 text-center fw-bold fs-3"},b={class:"tss-bg-secondary-dark p-3"},B={class:"mb-3"},T={class:"transaction-summary-stats"},k=t("th",null,"Total Pendapatan",-1),C=t("td",null,":",-1),I=t("th",null,"Pendapatan Rata-Rata",-1),N=t("td",null,":",-1),O=t("th",null,"Jumlah Pesanan",-1),P=t("td",null,":",-1),z=t("hr",null,null,-1),L={class:"list-group transaction-summary-list"},$=u({__name:"Summary",props:{summary:null},setup(s){return(e,a)=>(n(),l("div",S,[t("div",v,r(s.summary.dateString),1),t("div",b,[t("header",B,[t("table",T,[t("tr",null,[k,C,t("td",null,r(s.summary.hargaTotal),1)]),t("tr",null,[I,N,t("td",null,r(s.summary.hargaRata2),1)]),t("tr",null,[O,P,t("td",null,r(s.summary.count)+"x",1)])])]),z,t("ul",L,[(n(!0),l(i,null,m(s.summary.orders,o=>(n(),_(f,{item:o},null,8,["item"]))),256))])])]))}}),w={class:"horizontal-scroll mt-4"},U=u({__name:"App",setup(s){const e=p(),a=y();a.setLoading(!0);const o=new h(e.initialize).on("success",()=>{a.cleanup(),e.areTransactionsInitialized||a.setError(g,3e3)}).on("failure",c=>{console.error(c),a.setLoading(!1),a.setError(R)});return o.run(),x(()=>{o.cleanup()}),(c,A)=>(n(),l("div",w,[(n(!0),l(i,null,m(E(e).transactions,d=>(n(),_($,{summary:d},null,8,["summary"]))),256))]))}});export{U as default};