import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/requests/setup.dart';
import 'package:dio/dio.dart';

const String ACCOUNT_ROUTE = "$API/accounts";

Future<Response> login(String email, String password) {
  const String route = "$ACCOUNT_ROUTE/login";
  return dio.post(route, data: <String, String>{
    "email": email,
    "password": password,
  });
}

Future<Response> register(
    String email, String password, String name, String? gender, String telp) {
  const String route = "$ACCOUNT_ROUTE/register";
  return dio.post(route, data: <String, dynamic>{
    "email": email,
    "password": password,
    "name": name,
    "gender": gender,
    "telp": telp,
  });
}

Future<Response> getMe() {
  const String route = "$ACCOUNT_ROUTE/me";
  return dio.get(route);
}
