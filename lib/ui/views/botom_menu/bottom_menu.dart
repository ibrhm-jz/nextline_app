import 'package:flutter/material.dart';
import 'package:nextline_app/ui/views/task/task.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BotomMenu extends StatefulWidget {
  const BotomMenu({Key? key}) : super(key: key);

  @override
  _BotomMenuState createState() => _BotomMenuState();
}

class _BotomMenuState extends State<BotomMenu> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: SafeArea(
          child: _getPage(_currentIndex),
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Inicio"),
            selectedColor: Colors.indigo,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.checklist_outlined),
            title: const Text("Completado"),
            selectedColor: Colors.green,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.bar_chart),
            title: const Text("Estadisticas"),
            selectedColor: Colors.pinkAccent,
          ),
        ],
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return const TaskPage();

      case 1:
        return const TaskPage();
      case 2:
        return const TaskPage();
      default:
        return const TaskPage();
    }
  }
}
