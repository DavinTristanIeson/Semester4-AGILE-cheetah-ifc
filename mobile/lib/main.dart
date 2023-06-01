import 'package:cheetah_mobile/views/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CheetahApp());
}

class CheetahApp extends StatelessWidget {
  const CheetahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFB99878),
        scaffoldBackgroundColor: const Color(0xFF523112),
        colorScheme: const ColorScheme(
          primary: Color(0xFFB99878),
          secondary: Color(0xFFEBE6DD),
          secondaryContainer: Color(0xFFFFFBF4),
          background: Color(0xFF523112),
          brightness: Brightness.dark,
          error: Color(0xFFDC3545),
          surface: Color(0xFF523112),
          onBackground: Color(0xFF805024),
          onPrimary: Colors.black,
          onSecondary: Color(0xFF523112),
          onError: Colors.black,
          onSurface: Color(0xFFB99878),
        )
      ),
      home: const MainAppScaffold()
    );
  }
}