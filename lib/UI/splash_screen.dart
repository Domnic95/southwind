import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/UI/auth_wrapper.dart';
import 'package:southwind/data/providers/providers.dart';

class SplashScrren extends StatefulHookWidget {
  SplashScrren({Key? key}) : super(key: key);

  @override
  _SplashScrrenState createState() => _SplashScrrenState();
}

class _SplashScrrenState extends State<SplashScrren> {
  bool nextScreen = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        Duration(
          seconds: 5,
        ), () {
      setState(() {
        nextScreen = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = useProvider(authProvider);
    return nextScreen
        ? AuthWrapper()
        : Scaffold(
            body: Center(
              child: Image.asset(
                'assets/images/southwind_logo_single.png',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
