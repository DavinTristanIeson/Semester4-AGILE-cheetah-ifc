import 'package:flutter/material.dart';

import 'model.dart';

class OrdersProvider extends ChangeNotifier {
  bool isGridView = true;
  MenuTransaction? current;
  List<MenuOrder> orders = [];
  MenuOrder add(MenuItem item) {
    MenuOrder order = MenuOrder.from(item: item);
    orders.add(order);
    notifyListeners();
    return order;
  }

  replace(List<MenuOrder> orders) {
    this.orders = orders;
    notifyListeners();
  }

  void toggleGridView() {
    isGridView = !isGridView;
    notifyListeners();
  }
}

class OngoingTransactionProvider extends ChangeNotifier {
  late final MenuTransaction current;
}

class HistoryTransactionProvider extends ChangeNotifier {}

class AccountProvider extends ChangeNotifier {}
