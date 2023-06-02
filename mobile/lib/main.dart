import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/providers.dart';
import 'package:cheetah_mobile/requests/accounts.dart';
import 'package:cheetah_mobile/requests/setup.dart';
import 'package:cheetah_mobile/views/login/main.dart';
import 'package:cheetah_mobile/views/main.dart';
import 'package:flutter/material.dart';

import 'components/display/image.dart';
import 'package:provider/provider.dart';

import 'components/display/info.dart';

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
            colorScheme: const ColorScheme(
              primary: COLOR_PRIMARY,
              secondary: COLOR_SECONDARY,
              secondaryContainer: COLOR_SECONDARY,
              tertiary: COLOR_TERTIARY,
              background: COLOR_DARK,
              brightness: Brightness.dark,
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
          child: FutureBuilder(
            future: getMe(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ChangeNotifierProvider(
                  child: const MainPage(),
                  create: (_) => OrdersProvider()
                );
              } else if (snapshot.hasError) {
                return const LoginPage();
              } else {
                return const LoadingComponent();
              }
            },
          ),
        ));
  }
}
