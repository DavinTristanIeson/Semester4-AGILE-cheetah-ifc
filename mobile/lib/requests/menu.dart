import 'package:cheetah_mobile/requests/setup.dart';
import 'package:dio/dio.dart';

import '../helpers/constants.dart';
import '../helpers/model.dart';


Future<PaginatedApiResult<MenuItem>> getMenu(int page,
  {String? search, String? category}) async {
  const String MENU_ROUTE = "$API/menu";
    
  try {
    final Response res = await dio.get(MENU_ROUTE,
      queryParameters: <String, dynamic>{
          "page": page,
          if (search != null) "search": search,
          if (category != null) "category": category,
      });
    return PaginatedApiResult.fromJson(res.data, (data) => MenuItem.fromJson(data));
  } catch (e){
    throw Exception("Gagal memuat menu. Mohon dicoba lagi pada waktu lain.");
  }
}

Future<List<String>> getFilterCategories() async {
  const String CATEGORIES_ROUTE = "$API/menu/categories";
   try {
    final Response<List<dynamic>> res = await dio.get(CATEGORIES_ROUTE);
    return res.data!.map((x) => x as String).toList();
  } catch (e){
    throw Exception("Gagal memuat kategori untuk filter. Mohon dicoba lagi pada waktu lain.");
  }
}
