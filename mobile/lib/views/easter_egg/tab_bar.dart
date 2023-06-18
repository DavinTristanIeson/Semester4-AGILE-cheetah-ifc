import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/styles.dart';
import 'package:flutter/material.dart';

/* Pertemuan 7
- Tab Bar */
class TabBarShowcasePage extends StatefulWidget {

  const TabBarShowcasePage({super.key});

  @override
  State<TabBarShowcasePage> createState() => _TabBarShowcasePageState();
}

class _TabBarShowcasePageState extends State<TabBarShowcasePage> with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    _tab = TabController(length: 3, vsync: this);
    super.initState();
  }

  Widget buildTabView(Color color){
    return Container(
      decoration: BoxDecoration(color: color),
      child: Center(child: Text("R: ${color.red}, G: ${color.green}, B: ${color.blue}, A: ${color.alpha}", style: TEXT_IMPORTANT)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demonstrasi Tab Bar"),
        bottom: TabBar(
          controller: _tab,
          tabs: const [
            Tab(child: Text("Merah", style: TextStyle(color: COLOR_PRIMARY))),
            Tab(child: Text("Biru", style: TextStyle(color: COLOR_PRIMARY))),
            Tab(child: Text("Hijau", style: TextStyle(color: COLOR_PRIMARY))),
          ]
        )
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          buildTabView(Colors.red),
          buildTabView(Colors.blue),
          buildTabView(Colors.green),
        ],
      ),
    );
  }
}