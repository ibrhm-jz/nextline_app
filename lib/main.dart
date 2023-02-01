import 'package:flutter/material.dart';
import 'package:nextline_app/ui/views/botom_menu/bottom_menu.dart';
import 'package:nextline_app/ui/views/task/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestión de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
        ),
      ),
      home: const TaskPage(),
      initialRoute: '/home',
      routes: {
        '/home': (BuildContext context) => const BotomMenu(),
        '/task': (BuildContext context) => const TaskPage(),
      },
    );
  }
}
