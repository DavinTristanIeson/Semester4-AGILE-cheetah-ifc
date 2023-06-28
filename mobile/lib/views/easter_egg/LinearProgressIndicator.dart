// ignore_for_file: file_names

import 'package:flutter/material.dart';
class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
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
      appBar: AppBar(
        title: const Text('Stateful Flutter Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Transform.scale(
              scale: 0.7, // Adjust the scale factor as desired
              child: LinearProgressIndicator(
                value: _progress,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _incrementProgress,
              child: const Text('Increment Progress'),
            ),
          ],
        ),
      ),
    );
  }
}
