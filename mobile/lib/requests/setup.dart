import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';


final dio = Dio();

Future<void> setupDio() async {
  dio.options.baseUrl = API;
  final directory = await getApplicationDocumentsDirectory();
  final jar = PersistCookieJar(
    storage: FileStorage("${directory.path}/.cookies/")
  );
  dio.interceptors.add(CookieManager(jar));
}