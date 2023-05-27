export class MenuItem {
    id:number;
    name:string;
    category:string;
    description:string;
    img:string;
    price:number;
    constructor(
        id:number,
        name:string,
        category:string,
        description:string,
        img:string,
        price:number
    ){
        this.id = id;
        this.name = name;
        this.category = category;
        this.description = description;
        this.img = img;
        this.price = price;
    }
    get harga(){
        return MenuItem.toRupiah(this.price);
    }
    static toRupiah(rupiah:number){
        return new Intl.NumberFormat("id", {style:"currency", currency: "IDR"}).format(rupiah);
    }
    static fromJSON(raw: any){
        return new MenuItem(raw.id, raw.name, raw.category, raw.description, raw.img, raw.price);
    }
}

export class MenuOrder extends MenuItem {
    quantity:number;
    note:string;
    constructor(item:MenuItem, quantity:number = 1, note:string = ""){
        super(item.id, item.name, item.category, item.description, item.img, item.price);
        this.quantity = quantity;
        this.note = note;
    }
    get harga(){
        return MenuItem.toRupiah(this.price * this.quantity);
    }
    copy(){
        return new MenuOrder(new MenuItem(this.id, this.name, this.category, this.description, this.img, this.price), this.quantity, this.note);
    }
}

export class UserAccount {
    readonly id:number;
    email:string;
    name:string;
    gender:boolean;
    telp:string;
    constructor(id:number, email:string, name:string, gender:boolean, telp:string){
        this.id = id;
        this.email = email;
        this.name = name;
        this.gender = gender;
        this.telp = telp;
    }
    static fromJSON(json:{
        id:number,
        email:string,
        name:string,
        gender:boolean,
        telp:string,
    }){
        return new UserAccount(json.id, json.email, json.name, json.gender, json.telp);
    }
}

export type OngoingOrderPhase = "pending"|"cooking"|"finished"|'canceled';
export class MenuTransaction {
    id:number;
    username:string;
    time:Date;
    orders:MenuOrder[];
    phase:OngoingOrderPhase;
    constructor (id:number, username:string, time:Date, orders:MenuOrder[], phase:OngoingOrderPhase){
        this.id = id;
        this.username = username;
        this.time = time;
        this.orders = orders;
        this.phase = phase;
    }
    get timeString(){
        // https://stackoverflow.com/questions/3552461/how-do-i-format-a-date-in-javascript
        return this.time.toLocaleDateString(undefined, {
            day: "2-digit",
            year: "numeric",
            month: "short",
            hour: "2-digit",
            minute: "2-digit",
            hour12: false,
        });
    }
    get totalPrice(){
        return this.orders.reduce((acc, cur) => acc + cur.price * cur.quantity, 0);
    }
    get hargaTotal(){
        return MenuItem.toRupiah(this.totalPrice);
    }
    static parseStatus(status:number): OngoingOrderPhase {
        switch (status){
            case 0: return "finished";
            case 1: return "cooking";
            case -1: return "canceled";
            default: return "pending";
        }
    }
    toStatus(){
        switch (this.phase){
            case "pending": return 2;
            case "cooking": return 1;
            case "finished": return 0;
            case "canceled": return -1;
        }
    }
    static fromJSON(json:any){
        return new MenuTransaction(json.id, json.user, new Date(json.time),
            json.records.map((y:any) => new MenuOrder(
            new MenuItem(y.id, y.name, "", "", "", y.price), y.quantity, y.note
            )), MenuTransaction.parseStatus(json.status)
        );
    }
    static fromJSONArray(json:any){
        return json.map((x:any) => MenuTransaction.fromJSON(x));
    }
}

export class TransactionSummary {
    orders: MenuOrder[];
    date:Date;
    totalPrice: number = 0;
    // jumlah pesanan
    count: number = 0;
    constructor(transactions:MenuTransaction[], date:Date){
        const uniques:{[key:number]: MenuOrder} = {};
        this.date = date;
        for (let tsc of transactions){
            for (let ord of tsc.orders){
                ord.note = "";
                if (!uniques.hasOwnProperty(ord.id)){
                    uniques[ord.id] = ord;
                } else {
                    uniques[ord.id].quantity += ord.quantity;
                }
                this.totalPrice += ord.price * ord.quantity;
                this.count += ord.quantity;
            }
        }
        this.orders = [];
        for (let ord in uniques){
            this.orders.push(uniques[ord]);
        }
        this.orders.sort((a, b)=>{
            return b.quantity - a.quantity;
        });
    }
    get averagePrice(){
        return this.totalPrice / this.count;
    }
    get dateString(){
        // https://stackoverflow.com/questions/3552461/how-do-i-format-a-date-in-javascript
        return this.date.toLocaleDateString(undefined, {
            day: "2-digit",
            year: "numeric",
            month: "short",
        });
    }
    get hargaTotal(){
        return MenuItem.toRupiah(this.totalPrice);
    }
    get hargaRata2(){
        return MenuItem.toRupiah(this.averagePrice);
    }
    append(transaction: MenuTransaction){
        for (let ord of transaction.orders){
            ord.note = "";
            const item = this.orders.find(x => x.id == ord.id);
            if (item) item.quantity += ord.quantity;
            else this.orders.push(ord);
            this.totalPrice += ord.price * ord.quantity;
            this.count += ord.quantity;
        }
    }
    private static dayOfDate(date:Date){
        return `${date.getFullYear()}-${date.getMonth()+1}-${date.getDate()}`;
    }
    static summarize(transactions: MenuTransaction[]){
        const dates:{[key:string]: MenuTransaction[]} = {};
        for (let transaction of transactions){
            const key = this.dayOfDate(transaction.time);
            if (!dates.hasOwnProperty(key)) dates[key] = [];
            dates[key].push(transaction);
        }
        const summaries = [];
        for (let date in dates){
            summaries.push(new TransactionSummary(dates[date], new Date(date)));
        }
        return summaries.sort();
    }
}