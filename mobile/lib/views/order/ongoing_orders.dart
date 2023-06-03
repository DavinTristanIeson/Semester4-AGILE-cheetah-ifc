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
          Expanded(
            child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, idx) =>
                    OrderItemListTile(item: orders[idx])),
          ),
          const Divider(),
          Row(
            children: [const Text("Total: "), Text(formatRupiah(total))],
          ),
          FutureButton(
              onPressed: createNewTransaction,
              child: const Text("Pesan"))
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

  void removeOrder() {
    // TODO: Remove order
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: GAP_SM),
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
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: FS_EMPHASIS)),
                Text(
                  "${item.harga}   x${item.quantity}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: FS_DEFAULT,
                  ),
                )
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
              onPressed: removeOrder,
            )),
      ),
    );
  }
}
