import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';

class JansenPage extends StatefulWidget {
  const JansenPage({Key? key}) : super(key: key);

  @override
  State<JansenPage> createState() => _JansenPageState();
}

/* Pertemuan 6
- Switch
- DropdownButton

Pertemuan 10
- Banner

Pertemuan 13
- Slider */
class _JansenPageState extends State<JansenPage> {
  late String _selectedOption = "Opsi 1";
  bool _switchValue = false;
  double _sliderValue = 0;

  void _onDropdownChanged(String? option) {
    setState(() {
      _selectedOption = option ?? "Opsi 1";
    });
  }

  void _onSwitchChanged(bool value) {
    setState(() {
      _switchValue = value;
    });
  }

  void _onSliderChanged(double value) {
    setState(() {
      _sliderValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Components'),
      ),
      body: Container(
        height: double.maxFinite,
        color: _switchValue ? Colors.yellow : Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Minggu 6',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const SizedBox(height: 10),
              const Text(
                'Switch',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              switchButton(),
              const SizedBox(height: 20),
              const Text(
                'Dropdown',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              dropdown(),
              const SizedBox(height: 50),
              const Text(
                'Minggu 10',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const SizedBox(height: 10),
              MaterialBanner(
                backgroundColor: _switchValue ? Colors.yellow : Colors.white,
                content: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Banner',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('Show Banner')
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => ScaffoldMessenger.of(context)
                      ..removeCurrentMaterialBanner()
                      ..showMaterialBanner(showBanner(context)),
                    child: const Text('Show Banner'),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Minggu 13',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Slider(
                activeColor: Colors.black,
                value: _sliderValue,
                min: 0,
                max: 100,
                onChanged: _onSliderChanged,
              ),
              Text('Slider Value: ${_sliderValue.toStringAsFixed(0)}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget switchButton() {
    return SwitchListTile(
      title: const Text('Switch'),
      value: _switchValue,
      onChanged: _onSwitchChanged,
      activeColor: Colors.black,
    );
  }

  Widget dropdown() {
    return DropdownButton<String>(
      value: _selectedOption,
      onChanged: _onDropdownChanged,
      items: <String>[
        'Opsi 1',
        'Opsi 2',
        'Opsi 3',
      ].map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      hint: const Text('Pilih opsi'),
    );
  }
}

showBanner(BuildContext context) {
  return MaterialBanner(
    content: const Text('Ini adalah contoh banner'),
    backgroundColor: COLOR_SECONDARY,
    leading: const Icon(
      Icons.info,
      color: Colors.orange,
    ),
    actions: [
      TextButton(
        onPressed: () =>
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
        child: const Text('Agree'),
      ),
      TextButton(
        onPressed: () =>
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
        child: const Text('Dismiss'),
      ),
    ],
  );
}
