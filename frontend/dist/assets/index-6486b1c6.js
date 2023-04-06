import{d as o,q as M,A as n,M as p,s as R,U as A,a as w,c as b,b as i,u as r,_ as j,e as z,F as C,o as O,R as N,f as a,w as l,n as m,C as V,r as v,g as u,h as H,i as D,j as q,k as x,l as d,m as B,p as F}from"./index-13c58849.js";const L=o("pageState",{state:()=>({isLoading:!1,isLoadingEphemeral:!1,errorMessage:"",timeoutID:-1}),actions:{beginLoading(){this.isLoadingEphemeral=!0,this.isLoading=!0},cleanup(){this.isLoading=!1,this.clearError()},setLoading(e){this.isLoading=e,this.isLoadingEphemeral=!1},cleanEphemeralLoading(){this.isLoadingEphemeral&&(this.isLoading=!1)},clearError(){clearTimeout(this.timeoutID),this.errorMessage="",this.cleanEphemeralLoading()},setError(e,t){this.errorMessage=e,clearTimeout(this.timeoutID),this.cleanEphemeralLoading(),t&&(this.timeoutID=setTimeout(()=>{this.errorMessage=""},t))}}}),J=o("currentOrders",{state:()=>({current:null,orders:[],viewedOrder:void 0}),getters:{totalPrice:e=>e.orders.reduce((t,s)=>t+s.price*s.quantity,0),hargaTotal:e=>M.toRupiah(e.orders.reduce((t,s)=>t+s.price*s.quantity,0))},actions:{async initialize(){const e=await fetch(n+"/orders/ongoing",{credentials:"include"});if(e.ok){const t=await e.json();this.current=p.fromJSON(t)}},addOrder(e){let t=this.orders.find(s=>s.id==e.id);t?t.quantity++:this.orders.push(new R(e))},removeOrder(e){let t=this.orders.indexOf(e);t!=-1&&this.orders.splice(t,1)},examineOrder(e){this.viewedOrder=e},async createTransaction(){this.viewedOrder=void 0;const e=await fetch(n+"/orders",{method:"POST",headers:{"Content-Type":"application/json"},credentials:"include",body:JSON.stringify(this.orders.map(t=>({name:t.name,price:t.price,quantity:t.quantity,note:t.note})))});if(e.ok){const t=await e.json();this.current=p.fromJSON(t),this.orders=[]}},finishTransaction(){this.current=null},cleanup(){this.current=null,this.orders=[],console.log(this.current,this.orders)}}}),h=20,ce=o("menu",{state:()=>({menu:[],page:0,isMenuInitialized:!1,searchTerm:"",filterCategories:[]}),getters:{allCategories(e){let t=[];for(let s of e.menu)t.includes(s.category)||t.push(s.category);return t},filteredMenuByCategory(e){return e.menu.filter(t=>e.filterCategories.includes(t.category))},filteredMenu(e){return this.filteredMenuByCategory.filter(t=>t.name.startsWith(e.searchTerm))},current(e){return this.filteredMenu.slice(e.page*h,e.page*h+h)},totalPages(e){return Math.floor(this.filteredMenu.length/h)}},actions:{async initialize(){if(this.page=0,this.searchTerm="",this.isMenuInitialized){this.initFilterCategories();return}const e=await fetch(n+"/menu/");if(e.ok){const t=await e.json();this.menu=t.map(s=>new M(s.id,s.name,s.category,s.description,s.img,s.price)),this.isMenuInitialized=!0,this.initFilterCategories()}},initFilterCategories(){if(this.isMenuInitialized)for(let e of this.menu)this.filterCategories.includes(e.category)||this.filterCategories.push(e.category)},changePage(e){this.page=Math.min(this.totalPages,Math.max(0,e))}}}),U=o("user",{state:()=>({user:null}),getters:{hasLogin:e=>e.user!==null},actions:{async initialize(){if(this.user)return!0;const e=await fetch(n+"/accounts/",{credentials:"include"});if(!e.ok)return!1;const t=await e.json();return this.user=new A(t.id,t.email,t.name,t.gender,t.telp),!0},login(e){this.user=e},logout(){this.user=null}}}),g=10,$=o("history",{state:()=>({history:[],page:0,isHistoryInitialized:!1}),getters:{current(e){return e.history.slice(e.page*g,e.page*g+g)},totalPages(e){return Math.floor(e.history.length/g)}},actions:{async initialize(){if(this.isHistoryInitialized)return;const e=await fetch(n+"/orders/history",{credentials:"include"});if(e.ok){const t=await e.json();this.history=p.fromJSONArray(t),this.isHistoryInitialized=!0}},changePage(e){this.page=Math.min(this.totalPages,Math.max(0,e))},cleanup(){this.isHistoryInitialized=!1,this.history=[]}}}),G=w({__name:"App",setup(e){const t=L();return(s,_)=>(O(),b(C,null,[i(j,{loading:r(t).isLoading},null,8,["loading"]),i(r(N)),i(z,{floating:!0,message:r(t).errorMessage,onClick:r(t).clearError},null,8,["message","onClick"])],64))}}),W={class:"navbar navbar-expand-lg fs-5"},Y={class:"container-fluid"},K=a("button",{class:"navbar-toggler",type:"button","data-bs-toggle":"collapse","data-bs-target":"#navbarSupportedContent","aria-controls":"navbarSupportedContent","aria-expanded":"false","aria-label":"Toggle navigation"},[a("span",{class:"navbar-toggler-icon"})],-1),Q={class:"collapse navbar-collapse",id:"navbarSupportedContent"},X={class:"navbar-nav me-auto mb-2 mb-lg-0"},Z={class:"nav-item"},ee={class:"nav-item"},te={class:"nav-item"},se=a("a",{href:"#",class:"nav-link"},"Logout",-1),ae=[se],ie=w({__name:"Home",setup(e){const t=H(),s=D(),_=L(),P=J(),S=$(),T=U();async function k(){try{(await fetch(n+"/accounts/logout",{credentials:"include",method:"POST"})).ok&&(P.cleanup(),S.cleanup(),T.logout(),s.replace({name:"login"}))}catch{_.setError(V)}}return(y,ne)=>{const c=v("RouterLink"),I=v("RouterView");return O(),b(C,null,[a("nav",W,[a("div",Y,[i(c,{class:"navbar-brand fs-2",to:"/order"},{default:l(()=>[u(" The Savory Spoon ")]),_:1}),K,a("div",Q,[a("ul",X,[a("li",Z,[i(c,{class:m(["nav-link",{active:r(t).name=="order"}]),to:"/order"},{default:l(()=>[u("Pesan Makanan")]),_:1},8,["class"])]),a("li",ee,[i(c,{class:m(["nav-link",{active:r(t).name=="history"}]),to:"/history"},{default:l(()=>[u("Sejarah Pesanan")]),_:1},8,["class"])]),a("li",te,[i(c,{class:m(["nav-link",{active:r(t).name=="account"}]),to:"/account"},{default:l(()=>[u("Akun Anda")]),_:1},8,["class"])]),a("li",{class:"nav-item",onClick:k},ae)])])])]),i(I)],64)}}});async function E(){try{const e=await fetch(n+"/accounts/me",{credentials:"include"});return e.ok&&!(await e.json()).isAdmin}catch(e){return console.error(e),!1}}const re=q({history:x("/"),routes:[{path:"/login",name:"login",async beforeEnter(e,t,s){await E()?s({name:"index"}):s()},component:()=>d(()=>import("./App-5e28d7c0.js"),["assets/App-5e28d7c0.js","assets/StatefulForm.vue_vue_type_script_setup_true_lang-76d72d8b.js","assets/index-13c58849.js","assets/index-17f4caf7.css","assets/TextInput.vue_vue_type_script_setup_true_lang-bd015f1a.js","assets/CheckboxInput.vue_vue_type_script_setup_true_lang-518f203b.js","assets/inputs-6139d781.js","assets/inputValidators-80e8cad1.js","assets/App-e1b61a24.css"])},{path:"/",name:"index",redirect:"/order",async beforeEnter(e,t,s){await E()?s():s({name:"login"})},component:ie,children:[{path:"/order",name:"order",component:()=>d(()=>import("./App-19d4be92.js"),["assets/App-19d4be92.js","assets/index-13c58849.js","assets/index-17f4caf7.css","assets/requests-89d0a4b8.js","assets/IconButton.vue_vue_type_style_index_0_lang-b0d09b56.js","assets/IconButton-e46a7ea5.css","assets/CheckboxInput.vue_vue_type_script_setup_true_lang-518f203b.js","assets/inputs-6139d781.js","assets/OrderListItem.vue_vue_type_script_setup_true_lang-f2209271.js","assets/App-b9ad4973.css"])},{path:"/history",name:"history",component:()=>d(()=>import("./App-50e61cde.js"),["assets/App-50e61cde.js","assets/Accordion.vue_vue_type_style_index_0_lang-8ee2a69f.js","assets/index-13c58849.js","assets/index-17f4caf7.css","assets/Accordion-4326cff9.css","assets/OrderListItem.vue_vue_type_script_setup_true_lang-f2209271.js","assets/requests-89d0a4b8.js","assets/App-e532b079.css"])},{path:"/account",name:"account",component:()=>d(()=>import("./App-01ec40e7.js"),["assets/App-01ec40e7.js","assets/index-13c58849.js","assets/index-17f4caf7.css","assets/inputs-6139d781.js","assets/TextInput.vue_vue_type_script_setup_true_lang-bd015f1a.js","assets/requests-89d0a4b8.js","assets/inputValidators-80e8cad1.js","assets/App-8478fa17.css"])}]}]}),f=B(G);f.use(re);f.use(F());f.mount("#app");export{J as a,L as b,ce as c,$ as d,U as u};
