// ignore_for_file: file_names

import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';

class CircleAndLinearPage extends StatefulWidget {
  const CircleAndLinearPage({super.key});

  @override
  CircleAndLinearPageState createState() => CircleAndLinearPageState();
}

class CircleAndLinearPageState extends State<CircleAndLinearPage> {
  double _progress = 0.0;

  void _incrementProgress() {
    setState(() {
      _progress += 0.1;
      if (_progress >= 1.0) {
        _progress = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_SECONDARY_DARK,
      appBar: AppBar(
        title: const Text('Ambatumorb Bar Progress'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://us-tuna-sounds-images.voicemod.net/7e5054b1-818c-45c4-b121-39b48e87b56e-1661083216463.jpg'),
                radius: 100.0,
              ),
            ),
            Transform.scale(
              scale: 0.7,
              child: LinearProgressIndicator(
                value: _progress,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _incrementProgress,
              child: const Text('Tambah'),
            ),
          ],
        ),
      ),
    );
  }
}
