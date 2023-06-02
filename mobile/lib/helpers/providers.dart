import 'package:flutter/material.dart';

import 'model.dart';

class PreferencesProvider extends ChangeNotifier {
  bool isGridView = false;
  void toggleGridView() {
    isGridView = !isGridView;
  }
}

class MenuItemProvider extends ChangeNotifier {
  List<MenuItem> items = [];
  MenuItemProvider() {
    // TODO: Fetch items
  }
}

class OrdersProvider extends ChangeNotifier {
  List<MenuOrder> orders = [];
  MenuOrder add(MenuItem item) {
    MenuOrder order = MenuOrder.from(item: item);
    orders.add(order);
    print(orders);
    notifyListeners();
    return order;
  }
}

class OngoingTransactionProvider extends ChangeNotifier {
  late final MenuTransaction current;
  OngoingTransactionProvider() {
    // TODO: Fetch current
  }
}

class HistoryTransactionProvider extends ChangeNotifier {
  HistoryTransactionProvider() {
    // TODO: Fetch items
  }
}

class AccountProvider extends ChangeNotifier {
  AccountProvider() {
    // TODO: Fetch account
  }
}
