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
        title: Text('Ambatumorb Bar Progress'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
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
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Tambah'),
              onPressed: _incrementProgress,
            ),
          ],
        ),
      ),
    );
  }
}
