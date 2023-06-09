
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/model.dart';
import '../../helpers/styles.dart';

class OrderRecordListTile extends StatelessWidget {
  final MenuTransactionRecord item;
  const OrderRecordListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        splashColor: COLOR_BRIGHT,
        titleAlignment: ListTileTitleAlignment.top,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.name, style: TEXT_DEFAULT),
            Text(
              "${item.harga}   x${item.quantity}",
              style: TEXT_DETAIL,
            ),
            if (item.note.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: GAP),
                child: Text(item.note, style: TEXT_DEFAULT),
              ),
          ],
        ),
      )
    );
  }
}

class MenuTransactionItem extends StatelessWidget {
  final MenuTransaction item;
  const MenuTransactionItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: COLOR_SECONDARY,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 500.0),
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(
                children: [
                  const TextSpan(text: "Pesanan oleh ", style: TEXT_DEFAULT),
                  TextSpan(text: item.user, style: TEXT_SEMIBOLD)
                ],
              )),
              Text(item.timeString, style: TEXT_DETAIL),
            ]
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (MenuTransactionRecord record in item.records)
              OrderRecordListTile(item: record),
            const Divider(thickness: 0.1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: GAP_LG, vertical: GAP),
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: "Total: ", style: TEXT_SEMIBOLD),
                    TextSpan(text: item.hargaTotal, style: TEXT_DETAIL),
                  ]
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}