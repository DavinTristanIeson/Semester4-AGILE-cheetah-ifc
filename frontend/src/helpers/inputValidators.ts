export const EMAIL_REGEX = /^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$/
// https://stackoverflow.com/questions/15472764/regular-expression-to-allow-spaces-between-words
export const NAME_REGEX = /^[a-zA-Z]+( [a-zA-Z]+)*$/
export const PHONE_REGEX = /^[0-9]{10,12}$/

export function validateEmail(email:string){
    if (email.length == 0) return "Email harus diisi";
    else if (!email.match(EMAIL_REGEX)) return "Format email tidak sesuai";
}
export function validatePassword(password:string){
    return password.length < 8 ? "Password harus terdiri dari minimal 8 karakter" : "";
}
export function validateName(name:string){
    if (name.length < 5) return "Nama harus terdiri dari minimal 5 karakter";
    else if (!name.match(NAME_REGEX)) return "Nama hanya boleh terdiri dari huruf alfabet dan satu spasi antar-kata";
}
export function validatePhoneNumber(phone:string){
    if (phone.length == 0) return "No. telp harus diisi";
    else if (!phone.match(PHONE_REGEX))  return "No. telp harus terdiri dari 10-12 angka";
}
export function isNotEmpty(errMsg:string){
    return function (value:string){
        return value.length > 0 ? "" : errMsg;
    }
}
