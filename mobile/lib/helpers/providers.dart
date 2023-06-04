import 'package:flutter/material.dart';

import 'model.dart';

class MenuParamsProvider extends ChangeNotifier {
  List<String> filterCategories = [];
  bool isGridView = true;
  String? category = "";
  String search = "";
  
  void setSearch(String search){
    this.search = search;
    notifyListeners();
  }
  void setCategory(String? category){
    this.category = category;
    notifyListeners();
  }
  void toggleGridView() {
    isGridView = !isGridView;
    notifyListeners();
  }
}


class OrdersProvider extends ChangeNotifier {
  MenuTransaction? current;
  List<MenuOrder> orders = [];

  void add(MenuItem item) {
    int idx = orders.indexWhere((element) => element.id == item.id);
    if (idx == -1){
      MenuOrder order = MenuOrder.from(item: item);
      orders.add(order);
    } else if (orders[idx].quantity < 9) {
      orders[idx].quantity++;
    }
    notifyListeners();
  }

  void edit(MenuOrder order, {int? quantity, String? note}){
    if (quantity != null)
      order.quantity = quantity;
    if (note != null)
      order.note = note;
    notifyListeners();
  }

  void remove(MenuOrder order){
    orders.remove(order);
    notifyListeners();
  }

  void replace(List<MenuOrder> orders) {
    this.orders = orders;
    notifyListeners();
  }

  void startTransaction(MenuTransaction transaction){
    orders.clear();
    current = transaction;
    notifyListeners();
  }
}