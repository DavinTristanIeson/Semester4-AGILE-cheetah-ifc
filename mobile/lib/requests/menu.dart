import 'package:cheetah_mobile/requests/setup.dart';
import 'package:dio/dio.dart';

import '../helpers/constants.dart';
import '../helpers/model.dart';

const String MENU_ROUTE = "$API/menu";

Future<PaginatedApiResult<MenuItem>> getMenu(int page,
  {String? search, String? category}) async {
    
  final Response res = await dio.get(MENU_ROUTE,
    queryParameters: <String, dynamic>{
        "page": page,
        if (search != null) "search": search,
        if (category != null) "category": category,
    });
  return PaginatedApiResult.fromJson(res.data, (data) => MenuItem.fromJson(data));
}
