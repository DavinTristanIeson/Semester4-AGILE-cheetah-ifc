import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/requests/setup.dart';
import 'package:dio/dio.dart';

const String ACCOUNT_ROUTE = "$API/accounts";

Future<Response> login(String email, String password) async {
  const String route = "$ACCOUNT_ROUTE/login";
  try {
    return await dio.post(route, data: <String, String>{
      "email": email,
      "password": password,
    });
  } catch (e) {
    if (e is DioError && e.response?.statusCode == 401) {
      throw Exception("Email atau password salah!");
    } else {
      throw Exception("Gagal masuk ke akun. Mohon dicoba pada waktu lain.");
    }
  }
}

Future<Response> register(String email, String password, String name,
    bool gender, String telp) async {
  const String route = "$ACCOUNT_ROUTE/register";
  try {
    return await dio.post(route, data: <String, dynamic>{
      "email": email,
      "password": password,
      "name": name,
      "gender": gender,
      "telp": telp,
    });
  } catch (e) {
    const String ERROR =
        "Gagal mendaftarkan akun. Mohon dicoba pada waktu lain.";
    if (e is DioError) {
      if (e.response?.statusCode != 400 || e.response?.data == null) {
        throw Exception(ERROR);
      }
      final resData = e.response?.data as Map<String, dynamic>;
      throw Exception(resData["message"]);
    } else {
      throw Exception(ERROR);
    }
  }
}

Future<Response> updateAccountInfo(
    {String? email,
    String? name,
    bool? gender,
    String? telp,
    String? password,
    String? verify}) async {
  const String route = "$ACCOUNT_ROUTE";
  try {
    final data = {
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (telp != null) 'telp': telp,
      if (password != null) 'password': password,
      if (verify != null) 'verify': verify,
    };

    return await dio.put(route, data: data);
  } catch (e) {
    const String ERROR =
        "Gagal memperbarui informasi akun. Mohon dicoba pada waktu lain.";
    if (e is DioError) {
      if (e.response?.statusCode != 400 || e.response?.data == null) {
        throw Exception(ERROR);
      }
      final resData = e.response?.data as Map<String, dynamic>;
      throw Exception(resData["message"]);
    } else {
      throw Exception(ERROR);
    }
  }
}

Future<int> getMe() async {
  const String route = "$ACCOUNT_ROUTE/me";
  final Response res = await dio.get(route);
  return res.data["id"];
}
