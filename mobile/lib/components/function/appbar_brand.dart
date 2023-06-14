import 'package:cheetah_mobile/views/easter_egg/main.dart';
import 'package:flutter/material.dart';

/* Pertemuan 2
- Navigator */
class TheSavorySpoonAppBarBrand extends StatelessWidget {
  const TheSavorySpoonAppBarBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EasterEggPage())),
      child: const Text("The Savory Spoon",
        style: TextStyle(
          fontFamily: "JosefinSans",
          fontSize: 24,
          fontWeight: FontWeight.bold,
        )
      ),
    );
  }
}