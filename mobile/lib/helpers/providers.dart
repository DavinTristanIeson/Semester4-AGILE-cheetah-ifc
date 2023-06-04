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

}