import 'package:cheetah_mobile/requests/setup.dart';
import 'package:dio/dio.dart';

import '../helpers/constants.dart';
import '../helpers/model.dart';

Future<MenuTransaction> postOrder(List<MenuOrder> orders) async {
  const String ORDER_ROUTE = "$API/orders";
  try {
    final Response res = await dio.post(ORDER_ROUTE,
      data: orders.map((x) => x.toJson()).toList(),
    );
    return MenuTransaction.fromJson(res.data);
  } catch (e){
    throw Exception("Gagal membuat pemesanan baru. Mohon dicoba ulang pada waktu lain.");
  }
}

Future<MenuTransaction?> getOngoing() async {
  const String ONGOING_ROUTE = "$API/orders/ongoing";
  try {
    final Response res = await dio.get(ONGOING_ROUTE);
    return MenuTransaction.fromJson(res.data);
  } catch (e){
    return null;
  }
}

Future<PaginatedApiResult<MenuTransaction>> getHistory(int page) async {
  const String HISTORY_ROUTE = "$API/orders/history";
  try {
    final Response res = await dio.get(HISTORY_ROUTE, queryParameters: <String, dynamic>{
      "page": page,
    });
    return PaginatedApiResult.fromJson(res.data, (data) => MenuTransaction.fromJson(data));
  } catch (e){
    throw Exception("Gagal mengambil riwayat pemesanan. Mohon dicoba ulang pada waktu lain.");
  }
}