import 'package:flutter/material.dart';

import 'router_class_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouterClass.generateRouter,
    );
  }
}

class MyAppNoInternet extends StatelessWidget {
  const MyAppNoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/noInternet',
      onGenerateRoute: RouterClass.generateRouter,
    );
  }
}
