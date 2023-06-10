import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/keys.dart';
import 'package:cheetah_mobile/helpers/providers.dart';
import 'package:cheetah_mobile/requests/accounts.dart';
import 'package:cheetah_mobile/requests/setup.dart';
import 'package:cheetah_mobile/views/login/main.dart';
import 'package:cheetah_mobile/views/main.dart';
import 'package:flutter/material.dart';

import 'components/display/image.dart';
import 'package:provider/provider.dart';

import 'components/function/fetch_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDio();
  runApp(const CheetahApp());
}

class CheetahApp extends StatelessWidget {
  const CheetahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          unselectedWidgetColor: COLOR_TERTIARY,
          cardTheme: const CardTheme(
            color: COLOR_SECONDARY,
          ),
          listTileTheme: const ListTileThemeData(
            tileColor: COLOR_SECONDARY,
            textColor: Colors.black,
          ),
          fontFamily: "Josefin Sans",
          primaryColor: COLOR_PRIMARY,
          scaffoldBackgroundColor: COLOR_DARK,
          buttonTheme: const ButtonThemeData(
            buttonColor: COLOR_PRIMARY,
            textTheme: ButtonTextTheme.primary,
          ),
          splashColor: COLOR_BRIGHT,
          appBarTheme: const AppBarTheme(
            backgroundColor: COLOR_DARK,
            titleTextStyle: TextStyle(
              fontSize: FS_EMPHASIS,
              fontWeight: FontWeight.bold,
              color: COLOR_PRIMARY,
            )
          ),
          dividerTheme: const DividerThemeData(
            color: COLOR_DARK,
          ),
          colorScheme: ColorScheme(
            primary: COLOR_PRIMARY,
            primaryContainer: Color.lerp(COLOR_PRIMARY, COLOR_DARK, 0.5),
            secondary: COLOR_SECONDARY,
            secondaryContainer: COLOR_SECONDARY,
            tertiary: COLOR_TERTIARY,
            background: COLOR_DARK,
            brightness: Brightness.light,
            error: COLOR_ERROR,
            errorContainer: COLOR_ERROR_CONTAINER,
            surface: COLOR_DARK,
            onBackground: COLOR_BRIGHT,
            onPrimary: Colors.black,
            onSecondary: COLOR_DARK,
            onError: Colors.black,
            onSurface: COLOR_PRIMARY,
          )),
        home: BackgroundImage(
          asset: BACKGROUND_IMAGE_PATH,
          child: FetchWrapper(
            key: loginKey,
            fetch: getMe,
            errorComponent: const LoginPage(),
            emptyComponent: const LoginPage(),
            builder: (context, data) {
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (context) => OrdersProvider()),
                  ChangeNotifierProvider(create: (context) => MenuParamsProvider()),
                ],
                child: const MainPage(),
              );
            }
          ),
        ));
  }
}
