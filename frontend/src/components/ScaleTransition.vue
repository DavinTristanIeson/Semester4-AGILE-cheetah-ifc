<template>
    <Transition name="scale">
        <slot></slot>
    </Transition>
</template>

<style>
.scale-enter-active {
    /* https://stackoverflow.com/questions/29786230/how-to-create-css3-bounce-effect */
    transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}
.scale-leave-active {
    transition: transform 0.3s;
}
.scale-enter-from,
.scale-leave-to {
    transform: scale(0%, 0%);
}
</style>