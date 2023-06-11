import 'package:flutter/material.dart';
import 'component.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16.0),
        const Text(
          'Email',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        CustomTextField(
          controller: controller,
          hintText: 'Data Email Sekarang',
        ),
      ],
    );
  }
}
