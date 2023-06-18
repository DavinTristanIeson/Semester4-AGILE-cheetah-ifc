import 'dart:io';

import 'package:cheetah_mobile/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../helpers/constants.dart';

/* Pertemuan 14
- Date Picker
- Time Picker

Pertemuan 15
- Image Picker
*/
class DateTimePickerThemes extends StatelessWidget {
  final Widget child;
  const DateTimePickerThemes({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TimePickerTheme(
      data: const TimePickerThemeData(
        backgroundColor: COLOR_DARK,
        dialHandColor: COLOR_SECONDARY,
        helpTextStyle: TEXT_HIGHLIGHT,
        dialTextStyle: TEXT_DETAIL,
        
      ),
      child: DatePickerTheme(
        data: const DatePickerThemeData(
          backgroundColor: COLOR_DARK,
          headerBackgroundColor: COLOR_PRIMARY_DARK,
          dayStyle: TEXT_HIGHLIGHT,
        ),
        child: child,
      )
    );
  }
}

class PickerShowcasePage extends StatefulWidget {
  const PickerShowcasePage({super.key});

  @override
  State<PickerShowcasePage> createState() => _PickerShowcasePageState();
}

class _PickerShowcasePageState extends State<PickerShowcasePage> {
  DateTime time = DateTime.now();
  XFile? image;
  final ImagePicker _picker = ImagePicker();
  
  String pad0(int number){
    return number.toString().padLeft(2, '0');
  }
  Widget buildDatePickerButton(){
    return ElevatedButton.icon(
      onPressed: () async {
        final result = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 30)),
          lastDate: DateTime.now().add(const Duration(days: 30))
        );
        if (result != null){
          setState(() => time = result);
        }
      },
      icon: const Icon(Icons.calendar_today),
      label: Text("${pad0(time.day)}/${pad0(time.month)}/${(time.year)}"),
    );
  }
  Widget buildTimePickerButton(){
    return ElevatedButton.icon(
      onPressed: () async {
        final result = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(time),
        );
        if (result != null){
          setState(() => time = time.copyWith(hour: result.hour, minute: result.minute));
        }
      },
      icon: const Icon(Icons.schedule),
      label: Text("${pad0(time.hour)}:${pad0(time.minute)}")
    );
  }

  void selectImage() async {
    final result = await _picker.pickImage(source: ImageSource.gallery);
    if (result != null){
      setState(() => image = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Date, Time, Image Picker")
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: COLOR_PRIMARY_DARK,
        ),
        padding: const EdgeInsets.all(GAP_LG),
        child: Column(
          children: [
            const Text("Date/Time Picker", style: TEXT_IMPORTANT),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: GAP, vertical: GAP_LG),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: buildDatePickerButton()),
                  const SizedBox(width: GAP_LG),
                  Expanded(child: buildTimePickerButton()),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: GAP, vertical: GAP_LG),
              child: Divider()
            ),
            const Text("Image Picker", style: TEXT_IMPORTANT),
            const SizedBox(height: GAP_LG),
            GestureDetector(
              onTap: selectImage,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(GAP)),
                      color: Colors.grey,
                    ),
                    width: 400.0,
                    height: 300.0,
                    child: Center(
                      child: image != null ?
                        Image.file(File(image!.path), width: 400.0, height: 300.0, fit: BoxFit.cover) :
                        const Text("Pilih Foto", style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        )))
                  ),
                  if (image != null)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5)
                        ),
                        padding: const EdgeInsets.all(GAP),
                        child: Text(image!.name, style: TEXT_SMALL_DETAIL.copyWith(color: COLOR_SECONDARY))
                      ),
                    )
                ],
              )
            ),
          ],
        ),
      )
    );
  }
}