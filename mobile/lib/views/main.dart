
import 'package:flutter/material.dart';

import '../helpers/constants.dart';
import 'account/main.dart';
import 'history/main.dart';
import 'order/main.dart';

class MainAppScaffold extends StatefulWidget {
  const MainAppScaffold({super.key});

  @override
  State<MainAppScaffold> createState() => _MainAppScaffoldState();
}

class _MainAppScaffoldState extends State<MainAppScaffold> {
  int _view = 0;

  AppBar buildAppBar(){
    return AppBar(
      title: const Text("The Savory Spoon", style: TextStyle(
        fontFamily: "JosefinSans",
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ))
    );
  }

  Widget buildView(){
    switch (_view){
      case 1:
        return const HistoryView();
      case 2:
        return const AccountView();
      case 0:
      default:
        return const OrderView();
    }
  }

  Widget buildBottomNavBar(BuildContext context){
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedItemColor: Theme.of(context).colorScheme.secondary,
      unselectedItemColor: Theme.of(context).colorScheme.primary,
      currentIndex: _view,
      onTap: (selected) => setState(() => _view = selected),
      items: [
        BottomNavigationBarItem(
          icon: Icon(_view == 0 ? Icons.menu_book : Icons.menu_book_outlined),
          label: "Pesan"
        ),
        BottomNavigationBarItem(
          icon: Icon(_view == 1 ? Icons.money : Icons.money_outlined),
          label: "Sejarah"
        ),
        BottomNavigationBarItem(
          icon: Icon(_view == 2 ? Icons.person : Icons.person_outlined),
          label: "Akun"
        )
      ],
    );
  }

  Widget wrapBackground(Widget widget){
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          fit: BoxFit.cover,
          image: AssetImage(BACKGROUND_IMAGE_PATH)
        )
      ),
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: wrapBackground(buildView()),
      bottomNavigationBar: buildBottomNavBar(context)
    );
  }
}