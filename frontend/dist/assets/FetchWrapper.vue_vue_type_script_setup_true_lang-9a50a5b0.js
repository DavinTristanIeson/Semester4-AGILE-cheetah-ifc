import{I as u}from"./requests-48cb46fe.js";import{d as i,l as f,G as m,D as p,Y as E,q as _,K as y,t as w,i as d,C as h,P as v}from"./index-a9e6055c.js";const K=i({__name:"FetchWrapper",props:{fn:{type:Function},injectKey:null,retryInterval:null,alwaysShow:{type:Boolean}},emits:["success","failure"],setup(l,{emit:o}){const s=l,r=d(v),t=f({show:!!s.alwaysShow}),a=m(null),c=new u(s.fn,s.retryInterval).on("success",e=>{t.show=!0,r==null||r.clear(),o("success",e),a.value=e}).on("failure",e=>{let n;e instanceof Error?n=e.message:n=h,r==null||r.setError(n,null),o("failure",e)});return c.run(),p(s.injectKey||E,a),_(()=>{c.cleanup()}),(e,n)=>t.show?y(e.$slots,"default",{key:0}):w("",!0)}});export{K as _};
