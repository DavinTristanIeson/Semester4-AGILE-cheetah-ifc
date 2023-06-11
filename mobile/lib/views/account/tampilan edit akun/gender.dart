import 'package:flutter/material.dart';
import 'component.dart';

class GenderSelection extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String> onChanged;

  const GenderSelection({
    Key? key,
    required this.selectedGender,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16.0),
        const Text(
          'Jenis Kelamin',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        CustomRadioGroup(
          value: 'pria',
          groupValue: selectedGender,
          label: 'Pria',
          onChanged: onChanged,
        ),
        CustomRadioGroup(
          value: 'wanita',
          groupValue: selectedGender,
          label: 'Wanita',
          onChanged: onChanged,
        ),
      ],
    );
  }
}
