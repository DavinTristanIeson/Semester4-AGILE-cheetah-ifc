import{a as h,t as E,S as w,C as i,y as g,u as n,c as y,f as e,D as r,v as b,B as d,o as _,i as P,A as p}from"./index-13c58849.js";import{T as N}from"./inputs-6139d781.js";import{_ as R}from"./TextInput.vue_vue_type_script_setup_true_lang-bd015f1a.js";import{I as S}from"./requests-89d0a4b8.js";import{u as k,b as v}from"./index-6486b1c6.js";import{i as C}from"./inputValidators-80e8cad1.js";const O={key:0,class:"tss-bg-secondary p-4 mt-5 rounded w-50 m-auto"},T={class:"account-detail-table mb-5"},x=e("td",null,"Email",-1),A=e("td",null,":",-1),B=e("td",null,"Nama",-1),I=e("td",null,":",-1),q=e("td",null,"Jenis Kelamin",-1),D=e("td",null,":",-1),j=e("td",null,"No. Telp",-1),V=e("td",null,":",-1),F=h({__name:"App",setup(J){const s=k(),a=E({requirePassword:!1}),m=P(),l=new N("Password","",C("Password harus diisi!")),o=v();async function f(){if(!a.requirePassword){a.requirePassword=!0;return}try{const t=await fetch(p+"/accounts/",{method:"DELETE",credentials:"include",headers:{"Content-Type":"application/json"},body:JSON.stringify({password:l.value})});if(t.ok)s.logout(),await fetch(p+"/accounts/logout",{method:"POST",credentials:"include"}),m.replace({name:"login"});else{const{message:c}=await t.json();o.setError(c,3e3)}}catch(t){console.error(t),o.setError(i,3e3)}}o.setLoading(!0);const u=new S(s.initialize).on("success",t=>{o.cleanup(),t||o.setError(w,3e3)}).on("failure",t=>{console.error(t),o.setError(i)});return u.run(),g(()=>{u.cleanup()}),(t,c)=>n(s).user?(_(),y("div",O,[e("table",T,[e("tr",null,[x,A,e("td",null,r(n(s).user.email),1)]),e("tr",null,[B,I,e("td",null,r(n(s).user.name),1)]),e("tr",null,[q,D,e("td",null,r(n(s).user.gender?"Pria":"Wanita"),1)]),e("tr",null,[j,V,e("td",null,r(n(s).user.telp),1)])]),a.requirePassword?(_(),b(R,{key:0,input:n(l)},null,8,["input"])):d("",!0),e("button",{class:"btn btn-danger w-100",onClick:f},"Delete Akun")])):d("",!0)}});export{F as default};