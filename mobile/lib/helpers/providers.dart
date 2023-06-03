import 'package:flutter/material.dart';

import 'model.dart';

class OrdersProvider extends ChangeNotifier {
  bool isGridView = true;
  MenuTransaction? current;
  List<MenuOrder> orders = [];

  List<String> filterCategories = [];
  String? category = "";
  String search = "";
  void add(MenuItem item) {
    int idx = orders.indexWhere((element) => element.id == item.id);
    if (idx == -1){
      MenuOrder order = MenuOrder.from(item: item);
      orders.add(order);
    } else {
      orders[idx].quantity++;
    }
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
  
  void toggleGridView() {
    isGridView = !isGridView;
    notifyListeners();
  }

  void setSearch(String search){
    this.search = search;
    notifyListeners();
  }
  void setCategory(String? category){
    this.category = category;
    notifyListeners();
  }
}