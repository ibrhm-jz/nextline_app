import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:nextline_app/ui/views/botom_menu/bottom_menu.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: Center(
        child: AnimatedSplashScreen(
          duration: 2000,
          splash: const Text(
            'NextLine\nGestión de Tareas',
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          nextScreen: const BotomMenu(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.white,
          centered: true,
        ),
      ),
    );
  }
}
