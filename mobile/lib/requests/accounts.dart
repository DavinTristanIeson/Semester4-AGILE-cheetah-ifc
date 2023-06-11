import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/model.dart';
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
    if (e is DioError && e.response?.data != null) {
      final resData = e.response?.data as Map<String, dynamic>;
      throw Exception(resData["message"] ?? ERROR);
    } else {
      throw Exception(ERROR);
    }
  }
}

Future<UserAccount> getAccount() async {
  try {
    final Response<Map<String, dynamic>> res = await dio.get(ACCOUNT_ROUTE);
    return UserAccount.fromJson(res.data!);
  } catch (e){
    const ERROR = "Gagal mengambil informasi akun. Mohon dicoba ulang pada waktu lain.";
    if (e is DioError && e.response?.data != null) {
      throw Exception((e.response?.data as Map<String, dynamic>)["message"] ?? ERROR);
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
  try {
    final data = {
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (telp != null) 'telp': telp,
      if (password != null) 'password': password,
      if (verify != null) 'verify': verify,
    };

    return await dio.put(ACCOUNT_ROUTE, data: data);
  } catch (e) {
    const String ERROR =
        "Gagal memperbarui informasi akun. Mohon dicoba pada waktu lain.";
    if (e is DioError && e.response?.data != null) {
      final resData = e.response?.data as Map<String, dynamic>;
      throw Exception(resData["message"] ?? ERROR);
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

Future<void> logout() async {
  try {
    await dio.post("$ACCOUNT_ROUTE/logout");
  } catch (e){
    throw Exception("Gagal logout anda dari akun. Mohon dicoba ulang pada waktu lain.");
  }
}

Future<void> deleteAccount(String password) async {
  try {
    await dio.delete(ACCOUNT_ROUTE, data: <String, String>{
      "password": password,
    });
  } catch (e) {
    throw Exception("Gagal menghapus akun anda. Mohon dicoba ulang pada waktu lain.");
  }
}