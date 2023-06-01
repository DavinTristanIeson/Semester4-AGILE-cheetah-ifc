import 'package:flutter/material.dart';

import 'model.dart';

class MenuItemProvider extends ChangeNotifier {
  List<MenuItem> items = [];
  MenuItemProvider(){
    // TODO: Fetch items
  }
}

class OrdersProvider extends ChangeNotifier {
  List<MenuOrder> orders = [];
}

class OngoingTransactionProvider extends ChangeNotifier {
  late final MenuTransaction current;
  OngoingTransactionProvider(){
    // TODO: Fetch current
  }
}

class HistoryTransactionProvider extends ChangeNotifier {
  HistoryTransactionProvider(){
    // TODO: Fetch items
  }
}

class AccountProvider extends ChangeNotifier {
  AccountProvider(){
    // TODO: Fetch account
  }
}