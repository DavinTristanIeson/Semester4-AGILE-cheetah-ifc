export abstract class InputObject<T = any> {
    value:T;
    error:string;
    readonly label:string;
    readonly id:string;
    abstract type: string;
    abstract validate: ()=>boolean;
    constructor(label:string, initialValue:T){
        this.error = "";
        this.value = initialValue;
        this.label = label;
        this.id = this.label + Math.random().toString().substring(2);
    }
}

interface TextInputObjectOptions {
    placeholder:string,
    semanticType:"email"|"password"|"text",
}
export class TextInputObject extends InputObject<string> {
    type: string = "text";
    validate: ()=>boolean;
    options:TextInputObjectOptions;
    constructor(label:string, initialValue:string, validator:(value:string)=>string|undefined, options:Partial<TextInputObjectOptions>={}){
        super(label, initialValue);
        this.validate = function (){
            this.error = validator(this.value) ?? "";
            return this.error.length == 0;
        }
        this.options = {
            placeholder: options.placeholder ?? label,
            semanticType: options.semanticType ?? "text",
        }
    }
}


export type ChoiceInputOption = {label:string, value:string}
export class RadioInputObject extends InputObject<string> {
    type: string = "radio";
    options:ChoiceInputOption[];
    validate: ()=>boolean;
    constructor(label:string, initialValue:string, options:ChoiceInputOption[], errorMessage:string){
        super(label, initialValue);
        this.options = options;
        this.validate = function (){
            this.error = this.options.find(x => this.value == x.value) ? "" : errorMessage;
            return this.error.length == 0;
        }
    }
}

export class CheckboxInputObject extends InputObject<string[]> {
    type: string = "checkbox";
    options: ChoiceInputOption[];
    validate: ()=>boolean;
    constructor(label:string, initialValue:string[], options:ChoiceInputOption[], validator:(chosen:string[])=>string){
        super(label, initialValue);
        this.options = options;
        this.validate = function (){
            this.error = validator(this.value);
            return this.error.length == 0;
        }
    }
}

export const TypeGuards = {
    isText(input:InputObject): input is TextInputObject {
        return input.type == "text";
    },
    isRadio(input:InputObject): input is RadioInputObject {
        return input.type == "radio";
    },
    isCheckbox(input:InputObject): input is CheckboxInputObject {
        return input.type == "checkbox";
    }
}