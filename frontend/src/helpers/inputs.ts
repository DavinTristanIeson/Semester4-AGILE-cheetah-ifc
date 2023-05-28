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
    isTextarea: boolean;
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
            isTextarea: !!options.isTextarea,
        }
    }
}

interface NumberInputObjectOptions {
    isInteger: boolean;
}
export class NumberInputObject extends InputObject<number>{
    type: string = "number";
    validate: () => boolean;
    options: NumberInputObjectOptions;
    constructor(label: string, initialValue: number, validator: (value: number) => string|undefined, options?: Partial<NumberInputObjectOptions>){
        super(label, initialValue);
        this.validate = function (){
            if (isNaN(this.value)){
                this.value = 0;
            }
            this.error = validator(this.value) ?? "";
            return this.error.length == 0;
        }
        this.options = {
            isInteger: options?.isInteger ?? false,
        };
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
    constructor(label:string, initialValue:string[], options:ChoiceInputOption[], validator:(chosen:string[])=>string|undefined){
        super(label, initialValue);
        this.options = options;
        this.validate = function (){
            this.error = validator(this.value) ?? "";
            return this.error.length == 0;
        }
    }
}

interface FileInputObjectOptions {
    accept:string,
}
export class FileInputObject extends InputObject<File|undefined> {
    type:string = "file"
    options:FileInputObjectOptions
    validate: () => boolean;
    constructor(label:string, validator: (file?:File) => string|undefined, options?:Partial<FileInputObjectOptions>){
        super(label, undefined);
        this.options = {
            accept: options?.accept ?? "*",
        }
        this.validate = function () {
            this.error = validator(this.value) ?? "";
            return this.error.length == 0;
        }
    }
}
export class SelectInputObject extends InputObject<string> {
    type = "select"
    validate: () => boolean;
    selection: ChoiceInputOption[];
    constructor(label: string, initialValue: string, selection: ChoiceInputOption[], validator: (data: string) => string | undefined){
        super(label, initialValue);
        this.selection = selection;
        this.validate = function (){
            this.error = validator(this.value) ?? "";
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