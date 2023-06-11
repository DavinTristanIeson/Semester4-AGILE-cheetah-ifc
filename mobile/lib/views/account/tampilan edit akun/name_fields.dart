import 'package:flutter/material.dart';
import 'component.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;

  const NameField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const SizedBox(height: 16.0),
      const Text(
        'Nama',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      CustomTextField(
        controller: controller,
        hintText: 'Data Nama sekarang',
      ),
    ]);
  }
}
