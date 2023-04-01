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

export type OngoingOrderPhase = "pending"|"cooking"|"finished";
export class MenuTransaction {
    id:number;
    username:string;
    time:Date;
    orders:MenuOrder[];
    phase:OngoingOrderPhase;
    constructor (id:number, username:string, time:Date, orders:MenuOrder[], phase:OngoingOrderPhase){
        this.id = id;
        this.username = username;
        this.time = new Date(time);
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
}