<script setup lang="ts">
import TextInput from '@/components/input/TextInput.vue';
import NumberInput from '@/components/input/NumberInput.vue';
import SelectInput from '@/components/input/SelectInput.vue';
import type { MenuItem } from '@/helpers/classes';
import { isNotEmpty, isNotFalsey, noValidate, validateImageURL, validatePrice } from '@/helpers/inputValidators';
import { NumberInputObject, SelectInputObject, TextInputObject } from '@/helpers/inputs';
import type { EditMenuPayload } from './types';
import { inject, ref } from 'vue';
import { formatFilterCategory } from '@/helpers/format';
import MaybeImage from '@/components/display/MaybeImage.vue';
import { MENU_CATEGORIES_KEY } from '@/helpers/keys';

const props = defineProps<{
    item: MenuItem|null
}>();
const emit = defineEmits<{
    (e: "edit", item: EditMenuPayload, original: MenuItem|null): void;
    (e: "close"): void;
    (e: "delete", id: number): void;
}>();

const state = {
    isValidating: false,
}
const categories = inject(MENU_CATEGORIES_KEY)!;

const inputs = {
    name: new TextInputObject("Nama", props.item?.name ?? "", isNotEmpty("Nama menu tidak boleh kosong!")),
    category: new SelectInputObject(
        "Kategori", props.item?.category ?? "",
        (categories.value || []).map(x => ({label: formatFilterCategory(x), value: x})),
        isNotFalsey("Kategori menu tidak boleh kosong")
    ),
    description: new TextInputObject("Deskripsi", props.item?.description ?? "", noValidate, {
        isTextarea: true,
    }),
    price: new NumberInputObject("Harga", props.item?.price ?? 0, validatePrice),
};
const imageInput = ref(new TextInputObject("Link Gambar", props.item?.img ?? "", validateImageURL));

function onSubmit(){
    state.isValidating = true;
    let hasError = false;
    for (let k in inputs){
        const error = !inputs[k as keyof typeof inputs].validate();
        hasError = hasError || error;
    }
    hasError = hasError || !imageInput.value.validate();
    if (hasError) return;
    emit("edit", {
        name: inputs.name.value,
        category: inputs.category.value!,
        description: inputs.description.value,
        img: imageInput.value.value,
        price: inputs.price.value,
    }, props.item);
}
</script>

<template>
    <div class="modal modal-lg d-block" tabindex="-1"
        aria-hidden="true" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header tss-bg-secondary">
                    <h5 class="modal-title">{{ item?.name || "Menu Baru" }}</h5>
                    <button class="btn-close" @click="$emit('close')"></button>
                </div>
                <div class="modal-body">
                    <div class="d-lg-flex d-block mb-3">
                        <MaybeImage
                            :src="imageInput.value" :alt="item?.name || 'Display Image'"
                            class="edit-modal-img"
                        />
                        <div class="mx-3 edit-modal-inputs">
                            <TextInput :input="inputs.name" :shouldValidate="state.isValidating"/>
                            <SelectInput :input="inputs.category" :shouldValidate="state.isValidating"/>
                            <TextInput :input="inputs.description" :shouldValidate="state.isValidating"/>
                            <TextInput :input="imageInput" :shouldValidate="state.isValidating"/>
                            <NumberInput :input="inputs.price" :shouldValidate="state.isValidating"/>
                        </div>               
                    </div>
                </div>
                <div class="modal-footer">
                    <button @click="onSubmit" class="float-end btn btn-primary">Simpan</button>
                    <button v-if="item" @click="emit('delete', item!.id)" class="float-end btn btn-danger">Hapus</button>
                </div>
            </div>
        </div>
    </div>
</template>

<style>
.edit-modal-inputs {
    width: 90%;
}
.edit-modal-img {
    width: 100%;
    height: 300px;
    object-fit: contain;
}
@media screen and (min-width: 996px){
    .edit-modal-img {
        max-width: 300px;
    }
}
</style>