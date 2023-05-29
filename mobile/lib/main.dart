import 'package:flutter/material.dart';

void main() {
  runApp(const CheetahApp());
}

class CheetahApp extends StatelessWidget {
  const CheetahApp({super.key});

// --primary: #B99878;
//     --primary-dark: #a07e5c;
//     --secondary: #EBE6DD;
//     --secondary-dark: #e0d1b4;
//     --secondary-light: #fffbf4;
//     --dark: #523112;
//     --shadow: #805024;
//     --highlight: #d39658;
//     --bs-primary: var(--primary);
//     --bs-secondary: var(--secondary);
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
          surface: Color(0xFFB99878),
          onBackground: Color(0xFF805024),
          onPrimary: Colors.black,
          onSecondary: Color(0xFF523112),
          onError: Colors.black,
          onSurface: Color(0xFF523112),
        )
      ),
      home: const Placeholder()
    );
  }
}