import{_ as S}from"./FetchWrapper.vue_vue_type_script_setup_true_lang-9a50a5b0.js";import{d as v,l as k,q as A,o as l,c as m,w as d,a as P,m as R,n as _,u as g,t as q,i as h,X as T,P as B,f as C,A as c,S as K}from"./index-a9e6055c.js";import{T as i,R as O}from"./inputs-cac6fc85.js";import{_ as $}from"./SelectInput.vue_vue_type_script_setup_true_lang-7a244b2a.js";import{c as x,e as U,f as V,i as I,d as J}from"./inputValidators-a742f5c9.js";import{_ as D}from"./StatefulForm.vue_vue_type_script_setup_true_lang-247379b3.js";import{U as F}from"./classes-929a4aba.js";import"./requests-48cb46fe.js";import"./RadioInput.vue_vue_type_script_setup_true_lang-8f6d06c1.js";const Y={class:"mt-4 my-2"},z=v({__name:"AccountForm",setup(E){const a=h(T);console.log(a.value);const t=h(B),e=k({requirePassword:!1,success:"",successTimeout:-1}),y=C();function N(s){return s.length>0?J(s):""}const u=[new i("Email",a.value.email??"",x,{semanticType:"email"}),new i("Password Baru","",N,{semanticType:"password"}),new i("Nama",a.value.name??"",U),new O("Jenis Kelamin",a.value.gender?"male":"female",[{label:"Pria",value:"male"},{label:"Wanita",value:"female"}],"Pilih salah satu jenis kelamin"),new i("No. Telp",a.value.telp??"",V)],o=new i("Password","",I("Password harus diisi!"),{semanticType:"password"});function b(s){const n=s["Password Baru"].length>0;if(n&&!e.requirePassword){e.requirePassword=!0;return}n&&o.value.length==0||t.run(async()=>{const r={email:s.Email,password:s["Password Baru"],name:s.Nama,gender:s["Jenis Kelamin"]=="male",telp:s["No. Telp"]};n&&(r.verify=o.value);const f=await fetch(`${c}/accounts`,{method:"PUT",headers:{"Content-Type":"application/json"},body:JSON.stringify(r),credentials:"include"});if(!f.ok){let p=K;try{p=(await f.json()).message}catch(w){console.error(w)}throw new Error(p)}e.success="Sukses mengubah informasi akun",clearTimeout(e.successTimeout),e.successTimeout=setTimeout(()=>{e.success=""},3e3),e.requirePassword=!1,u[1].error="",u[1].value="",a.value.email=r.email,a.value.name=r.name,a.value.gender=r.gender,a.value.telp=r.telp})}async function j(){if(!e.requirePassword){e.requirePassword=!0;return}o.value.length!=0&&t.run(async()=>{const s=await fetch(c+"/accounts",{method:"DELETE",credentials:"include",headers:{"Content-Type":"application/json"},body:JSON.stringify({password:o.value})});if(s.ok)await fetch(c+"/accounts/logout",{method:"POST",credentials:"include"}),y.replace({name:"login"});else{const{message:n}=await s.json();throw new Error(n)}})}return A(()=>{clearTimeout(e.successTimeout)}),(s,n)=>(l(),m(D,{class:"center-screen",onSubmit:b,action:"#",method:"put",inputs:u,purpose:"Simpan",validateFromStart:""},{after:d(()=>[P(R,{success:"",message:e.success},null,8,["message"])]),footer:d(()=>[_("div",Y,[e.requirePassword?(l(),m($,{key:0,input:g(o),shouldValidate:""},null,8,["input"])):q("",!0),_("button",{class:"btn btn-danger w-100 fs-5",onClick:j},"Delete Akun")])]),_:1}))}}),se=v({__name:"App",setup(E){async function a(){const t=await fetch(c+"/accounts",{credentials:"include"});if(!t.ok)throw t;const e=await t.json();return new F(e.id,e.email,e.name,e.gender,e.telp)}return(t,e)=>(l(),m(S,{fn:a,injectKey:g(T)},{default:d(()=>[P(z)]),_:1},8,["injectKey"]))}});export{se as default};