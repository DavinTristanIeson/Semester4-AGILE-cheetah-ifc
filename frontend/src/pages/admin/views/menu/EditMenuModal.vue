<script setup lang="ts">
import MenuItemModal from '@/components/display/MenuItemModal.vue';
import TextInput from '@/components/input/TextInput.vue';
import FileInput from '@/components/input/FileInput.vue';
import NumberInput from '@/components/input/NumberInput.vue';
import SelectInput from '@/components/input/SelectInput.vue';
import type { MenuItem } from '@/helpers/classes';
import { isNotEmpty, isNotFalsey, noValidate, validatePrice } from '@/helpers/inputValidators';
import { FileInputObject, NumberInputObject, SelectInputObject, TextInputObject } from '@/helpers/inputs';
import { useMenuStore } from '@/helpers/menuStore';
import type { EditMenuPayload } from './types';
import { ref } from 'vue';
import { formatFilterCategory } from '@/helpers/format';

const menu = useMenuStore();
const props = defineProps<{
    item: MenuItem
}>();
const emit = defineEmits<{
    (e: "edit", item: EditMenuPayload): void;
    (e: "close"): void;
}>();

const isValidating = ref(false);
const inputs = {
    name: new TextInputObject("Nama", props.item.name, isNotEmpty("Nama menu tidak boleh kosong!")),
    category: new SelectInputObject("Kategori", props.item.category, menu.filterCategories, formatFilterCategory, isNotFalsey("Kategori menu tidak boleh kosong")),
    description: new TextInputObject("Deskripsi", props.item.description, noValidate, {
        isTextarea: true,
    }),
    img: new FileInputObject("Gambar Makanan", noValidate),
    price: new NumberInputObject("Harga", props.item.price, validatePrice),
};
function onSubmit(){
    isValidating.value = true;
    let hasError = false;
    for (let k in inputs){
        hasError = hasError || inputs[k as keyof typeof inputs].validate();
    }
    if (hasError) return;
    emit("edit", {
        name: inputs.name.value,
        category: inputs.category.value!,
        description: inputs.description.value,
        img: inputs.img.value,
        price: inputs.price.value,
    });
    emit("close");
}
</script>

<template>
    <MenuItemModal :item="item" @close="$emit('close')">
        <template v-slot:side>
            <div class="w-100 mx-3">
                <TextInput :input="inputs.name" :shouldValidate="isValidating"/>
                <SelectInput :input="inputs.category" :shouldValidate="isValidating"/>
                <TextInput :input="inputs.description" :shouldValidate="isValidating"/>
                <FileInput :input="inputs.img" :shouldValidate="isValidating"/>
                <NumberInput :input="inputs.price" :shouldValidate="isValidating"/>
            </div>
        </template>
        <template v-slot:footer>
            <button @click="onSubmit" class="float-end btn btn-primary">Simpan</button>
        </template>
    </MenuItemModal>
</template>

<style>
.modal-img {
    max-width: 300px;
}
</style>