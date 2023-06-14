import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

enum InputFieldTheme {
  Light,
  Dark,
}

/* Pertemuan 3
- Text Field */
class TextInputField extends StatelessWidget {
  final String name;
  final String? Function(String?) validator;
  final String label;
  final String? hintText;
  final InputFieldTheme theme;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool obscureText;
  const TextInputField({
    super.key,
    required this.name,
    required this.label,
    required this.validator,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.theme = InputFieldTheme.Dark,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: theme == InputFieldTheme.Dark ? COLOR_SECONDARY : COLOR_DARK,
            fontSize: FS_EMPHASIS,
            fontFamily: FONT,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: FormBuilderTextField(
            decoration: const InputDecoration(
              fillColor: COLOR_SECONDARY,
              filled: true,
              errorStyle: TEXT_INPUT_ERROR,
            ),
            keyboardType: keyboardType,
            obscureText: obscureText,
            name: name,
            initialValue: initialValue,
            validator: validator,
          )
        ),
      ],
    );
  }
}

class RadioOption<T> {
  final String label;
  final T value;
  const RadioOption(this.value, this.label);
}

/* Pertemuan 5
- Radio Button */
class RadioInputField<T> extends StatelessWidget {
  final String name;
  final String? Function(T?) validator;
  final T? initialValue;
  final String label;
  final List<RadioOption<T>> options;
  final OptionsOrientation orientation;
  final InputFieldTheme theme;

  const RadioInputField({
    super.key,
    required this.name,
    required this.validator,
    required this.label,
    required this.options,
    this.initialValue,
    this.theme = InputFieldTheme.Dark,
    this.orientation = OptionsOrientation.vertical
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
          style: TextStyle(
            color: theme == InputFieldTheme.Dark ? COLOR_SECONDARY : COLOR_DARK,
            fontSize: FS_EMPHASIS,
          ),
        ),
        const SizedBox(height: 8),
        FormBuilderRadioGroup(
          name: name,
          validator: validator,
          initialValue: initialValue,
          orientation: orientation,
          activeColor: theme == InputFieldTheme.Dark ? COLOR_SECONDARY : COLOR_DARK,
          decoration: const InputDecoration(
            errorStyle: TEXT_INPUT_ERROR,
          ),
          options: options.map<FormBuilderFieldOption<T>>(
            (opt) => FormBuilderFieldOption<T>(
              value: opt.value,
              child: Text(opt.label, style: TextStyle(
                color: theme == InputFieldTheme.Dark ? COLOR_SECONDARY : COLOR_DARK
              )),
            )
          ).toList(),
        )
      ]
    );
  }
}