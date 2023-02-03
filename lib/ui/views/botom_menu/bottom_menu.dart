import 'package:flutter/material.dart';
import 'package:nextline_app/ui/views/chart/views/chart.dart';
import 'package:nextline_app/ui/views/task/views/completed_task.dart';
import 'package:nextline_app/ui/views/task/views/incompleted_task.dart';
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
      body: SafeArea(
        child: _getPage(_currentIndex),
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
            selectedColor: Colors.indigo,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.bar_chart),
            title: const Text("Estadisticas"),
            selectedColor: Colors.indigo,
          ),
        ],
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return const IncompleteTaskPage();
      case 1:
        return const CompletedTaskPage();
      case 2:
        return const Chart();
      default:
        return const IncompleteTaskPage();
    }
  }
}
