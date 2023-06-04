
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/display/image.dart';
import '../../components/display/interaction.dart';
import '../../helpers/constants.dart';
import '../../helpers/model.dart';
import '../../helpers/providers.dart';

class OrderFilterPopup extends StatelessWidget {
  final String? category;
  final List<String> filterCategories;
  final void Function(String?)? onSelected;
  const OrderFilterPopup({super.key, required this.category, required this.filterCategories, this.onSelected});

  String formatCategory(String category){
    return (category[0].toUpperCase() + category.substring(1))
      .split('-').join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MenuParamsProvider>();
    return Material(
      child: Column(
        children: [
          const DialogHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: provider.filterCategories.length,
              itemBuilder: (context, idx) {
                String category = provider.filterCategories[idx];
                return RadioListTile(
                  activeColor: COLOR_DARK,
                  groupValue: provider.category,
                  value: category,
                  title: Text(formatCategory(category), style: Theme.of(context).textTheme.displayMedium),
                  onChanged: (String? value) {
                    if (onSelected != null)
                      onSelected!(value);
                    Navigator.of(context).pop();
                  },
                );
              }
            ),
          )
        ],
      ),
    );
  }
}

class OrderEditDialog extends StatefulWidget {
  final MenuOrder item;
  const OrderEditDialog({super.key, required this.item});

  @override
  State<OrderEditDialog> createState() => _OrderEditDialogState();
}

class _OrderEditDialogState extends State<OrderEditDialog> {
  late int quantity;
  late TextEditingController _notes;
  @override
  void initState(){
    _notes = TextEditingController(text: widget.item.note);
    quantity = widget.item.quantity;
    super.initState();
  }

  void changeQuantity(int increment){
    setState(() {
      quantity = max(0, min(9, quantity + increment));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
          children: [
            const DialogHeader(),
            MaybeImage(url: widget.item.img, height: 300),
            Text(widget.item.name, style: Theme.of(context).textTheme.titleLarge),
            Text(widget.item.harga, style: Theme.of(context).textTheme.labelSmall),
            Text(widget.item.description, style: Theme.of(context).textTheme.bodyMedium),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => changeQuantity(-1),
                  icon: const Icon(Icons.remove)
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: GAP),
                  child: Text(quantity.toString(), style: Theme.of(context).textTheme.titleLarge)
                ),
                IconButton(
                  onPressed: () => changeQuantity(1),
                  icon: const Icon(Icons.add)
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: GAP, right: GAP, top: GAP, bottom: GAP_LG),
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Pesan tambahan kepada koki",
                  fillColor: Theme.of(context).colorScheme.secondaryContainer,
                  filled: true,
                ),
                controller: _notes,
                minLines: 4,
                maxLines: 8,
              ),
            ),
            ElevatedButton.icon(
              onPressed: (){
                context.read<OrdersProvider>().edit(widget.item, note: _notes.text, quantity: quantity);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.save),
              label: const Text("Simpan")
            )
          ],
        ),
      ),
    );
  }
}