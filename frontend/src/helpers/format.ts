export function formatFilterCategory(category: string){
    const temp = category.split('-').join(' ');
    return temp[0].toUpperCase() + temp.substring(1);
}