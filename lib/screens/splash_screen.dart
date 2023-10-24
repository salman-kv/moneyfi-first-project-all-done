import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moneymanager/screens/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return const MainPage();
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(child: Image.asset('assets/images/new log.png'))),
    );

  }
}
