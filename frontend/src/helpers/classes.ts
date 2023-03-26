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