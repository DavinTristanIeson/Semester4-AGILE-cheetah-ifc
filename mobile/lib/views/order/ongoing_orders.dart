import 'package:cheetah_mobile/components/display/info.dart';
import 'package:cheetah_mobile/components/display/interaction.dart';
import 'package:cheetah_mobile/components/function/future_input.dart';
import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/mixins.dart';
import 'package:cheetah_mobile/helpers/providers.dart';
import 'package:cheetah_mobile/views/order/dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/model.dart';
import '../../requests/orders.dart';

class OngoingOrdersBottomSheet extends StatelessWidget with SnackbarMessenger {
  const OngoingOrdersBottomSheet({super.key});

  Future<void> createNewTransaction(BuildContext context) async {
    final provider = context.read<OrdersProvider>();
    try {
      MenuTransaction transaction = await postOrder(provider.orders);
      provider.startTransaction(transaction);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } on Exception catch (e){
      sendError(context, e.toString());
    }
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
              Text("Total: ", style: theme.textTheme.displayMedium),
              Text(formatRupiah(total), style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.secondary,
              ))
            ],
          ),
          FutureButton(
            onPressed: () => createNewTransaction(context),
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
          const DialogHeader(),
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

  void viewDetail(BuildContext context) {
    final provider = context.read<OrdersProvider>();
    showDialog(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: provider,
          builder: (context, _) {
            return OrderEditDialog(item: item);
          },
        );
      }
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      color: Theme.of(context).colorScheme.error,
      onPressed: () {
        context.read<OrdersProvider>().remove(item);
      }
    );
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
          onTap: () => viewDetail(context),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name,
                  style: Theme.of(context).textTheme.displayMedium),
              Text(
                "${item.harga}   x${item.quantity}",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              if (item.note.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: GAP),
                  child: Text(item.note, style: Theme.of(context).textTheme.bodyMedium)
                )
            ],
          ),
          trailing: buildDeleteButton(context),
        )
      ),
    );
  }
}
