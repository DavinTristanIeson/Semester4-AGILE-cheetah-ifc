import 'package:cheetah_mobile/components/function/fetch_wrapper.dart';
import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/requests/accounts.dart';
import 'package:cheetah_mobile/requests/setup.dart';
import 'package:cheetah_mobile/views/login/main.dart';
import 'package:cheetah_mobile/views/main.dart';
import 'package:flutter/material.dart';

import 'components/display/background.dart';

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
        fontFamily: "Josefin Sans",
        primaryColor: const Color(0xFFB99878),
        scaffoldBackgroundColor: const Color(0xFF523112),
        colorScheme: const ColorScheme(
          primary: Color(0xFFB99878),
          secondary: Color(0xFFEBE6DD),
          secondaryContainer: Color(0xFFFFFBF4),
          tertiary: Colors.grey,

          background: Color(0xFF523112),
          brightness: Brightness.dark,

          error: Color(0xFFDC3545),
          errorContainer: Color.fromARGB(255, 217, 83, 96),
          surface: Color(0xFF523112),
          
          onBackground: Color(0xFF805024),
          onPrimary: Colors.black,
          onSecondary: Color(0xFF523112),
          onError: Colors.black,
          onSurface: Color(0xFFB99878),
        )
      ),
      home: BackgroundImage(
        asset: BACKGROUND_IMAGE_PATH,
        child: FutureBuilder(
          future: getMe(),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return const MainPage();
            } else if (snapshot.hasError){
              return const LoginPage();
            } else {
              return const LoadingComponent();
            }
          },
        ),
      )
    );
  }
}