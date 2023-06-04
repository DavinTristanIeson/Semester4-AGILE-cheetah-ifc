import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
class TextInputField extends StatelessWidget {
  final String name;
  final String? Function(String?) validator;
  final String label;
  final String? hintText;
  final Color? backgroundColor;
  final String? initialValue;
  const TextInputField({
    super.key,
    required this.name,
    required this.label,
    required this.validator,
    this.hintText,
    this.backgroundColor,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: COLOR_SECONDARY,
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
            decoration: InputDecoration(
              fillColor: backgroundColor ?? COLOR_SECONDARY,
              filled: true,
              errorStyle: TEXT_INPUT_ERROR,
            ),
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

class RadioInputField<T> extends StatelessWidget {
  final String name;
  final String? Function(T?) validator;
  final T? initialValue;
  final String label;
  final List<RadioOption<T>> options;
  final Color? textColor;
  final OptionsOrientation orientation;

  const RadioInputField({
    super.key,
    required this.name,
    required this.validator,
    required this.label,
    required this.options,
    this.initialValue,
    this.textColor,
    this.orientation = OptionsOrientation.vertical
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
          style: const TextStyle(
            color: COLOR_SECONDARY,
            fontSize: FS_EMPHASIS,
          ),
        ),
        const SizedBox(height: 8),
        FormBuilderRadioGroup(
          name: name,
          validator: validator,
          initialValue: initialValue,
          orientation: orientation,
          decoration: const InputDecoration(
            errorStyle: TEXT_INPUT_ERROR,
          ),
          options: options.map<FormBuilderFieldOption<T>>(
            (opt) => FormBuilderFieldOption<T>(
              value: opt.value,
              child: Text(opt.label, style: TextStyle(
                color: textColor
              )),
            )
          ).toList(),
        )
      ]
    );
  }
}