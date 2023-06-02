import 'package:cheetah_mobile/requests/setup.dart';
import 'package:dio/dio.dart';

import '../helpers/constants.dart';
import '../helpers/model.dart';

const String MENU_ROUTE = "$API/menu";

Future<List<MenuItem>> getMenu(int page,
    {String? search, String? category}) async {
  final Response res =
      await dio.get(MENU_ROUTE, queryParameters: <String, dynamic>{
    "page": page,
    if (search != null) "search": search,
    if (category != null) "category": category,
  });
  final Map<String, dynamic> json = res.data as Map<String, dynamic>;
  return (json["data"] as List<dynamic>)
      .map<MenuItem>((x) => MenuItem.fromJson(x))
      .toList();
}
