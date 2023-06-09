import 'package:cheetah_mobile/components/display/orders.dart';
import 'package:cheetah_mobile/helpers/model.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final transaction = MenuTransaction(id: 1, user: "Davin", time: DateTime.now(), records: [
      MenuTransactionRecord(id: 1, name: "A", price: 2000, quantity: 8, note: "hallo"),
      MenuTransactionRecord(id: 2, name: "B", price: 3000, quantity: 4, note: ""),
    ], status: OngoingOrderPhase.Finished);
    return MenuTransactionItem(item: transaction);
  }
}