import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:nextline_app/data/providers/task_provider.dart';
import 'package:nextline_app/ui/views/botom_menu/bottom_menu.dart';
import 'package:nextline_app/ui/views/splash/splash.dart';
import 'package:nextline_app/ui/views/task/views/incompleted_task.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es', null);
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => TaskProvider())],
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            supportedLocales: const [Locale('es'), Locale('en')],
            title: 'Gestión de Tareas',
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Okine',
              primarySwatch: Colors.indigo,
              textTheme: const TextTheme(
                headline1: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            // home: const TaskPage(),
            initialRoute: '/splash',
            routes: {
              '/splash': (BuildContext context) => Splash(),
              '/home': (BuildContext context) => const BotomMenu(),
              '/incomplete-task': (BuildContext context) =>
                  const IncompleteTaskPage(),
            },
          );
        });
  }
}
