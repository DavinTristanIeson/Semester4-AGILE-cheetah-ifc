import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateful Flutter Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
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
        title: Text('Stateful Flutter Page'),
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
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Increment Progress'),
              onPressed: _incrementProgress,
            ),
          ],
        ),
      ),
    );
  }
}
