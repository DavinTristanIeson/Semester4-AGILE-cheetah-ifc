import 'package:cheetah_mobile/components/display/info.dart';
import 'package:cheetah_mobile/components/function/future_input.dart';
import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/model.dart';

class OngoingOrdersBottomSheet extends StatelessWidget {
  const OngoingOrdersBottomSheet({super.key});

  Future<void> createNewTransaction() {
    return Future.delayed(const Duration(seconds: 1));
  }

  Widget buildBottomest(BuildContext context, int total){
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(color: theme.colorScheme.primary),
      padding: const EdgeInsets.all(GAP),
      child: Column(
        children: [
          Row(
            children: [
              Text("Total: ", style: theme.textTheme.titleMedium),
              Text(formatRupiah(total), style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.secondary,
              ))
            ],
          ),
          FutureButton(
            onPressed: createNewTransaction,
            child: const Text("Pesan"),
          )
        ],
      ),
    );
  }

  Widget buildOrderList(List<MenuOrder> orders){
    return Expanded(
      child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, idx) =>
              OrderItemListTile(item: orders[idx])),
    );
  }

  Widget buildListHeader(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<MenuOrder> orders = context.watch<OrdersProvider>().orders;
    int total = orders.isNotEmpty
        ? orders.map((ord) => ord.price).reduce((acc, cur) => acc + cur)
        : 0;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        children: [
          buildListHeader(context),
          orders.isNotEmpty ? 
            buildOrderList(orders) :
            const Expanded(child: ErrorMessage(reason: "Anda belum pesan apa-apa!")),
          if (orders.isNotEmpty)
            buildBottomest(context, total),
        ],
      ),
    );
  }
}

class OrderItemListTile extends StatelessWidget {
  final MenuOrder item;
  const OrderItemListTile({super.key, required this.item});

  void viewDetail() {
    // TODO: Open order detail dialog
  }

  void removeOrder(BuildContext context) {
    context.read<OrdersProvider>().remove(item);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: GAP_SM, horizontal: GAP_LG),
      decoration: const BoxDecoration(boxShadow: [SOLID_SHADOW]),
      child: Material(
        child: ListTile(
            splashColor: COLOR_BRIGHT,
            titleAlignment: ListTileTitleAlignment.top,
            onTap: viewDetail,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: Theme.of(context).textTheme.titleMedium),
                Text(
                  "${item.harga}   x${item.quantity}",
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
              onPressed: () => removeOrder(context),
            )),
      ),
    );
  }
}
