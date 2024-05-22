import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demoproapp/modules/splash/widgets/splash_logo_image_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkNetworkConnectivity();
    super.initState();
  }

  checkNetworkConnectivity() {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      // Received changes in available connectivity types!

      if ((result.contains(ConnectivityResult.ethernet))||(result.contains(ConnectivityResult.mobile))||(result.contains(ConnectivityResult.wifi))||(result.contains(ConnectivityResult.vpn))) {
        Timer(Durations.medium4,(){
          Navigator.pushNamed(context, '/login');
        });
      } else if ((result.contains(ConnectivityResult.none))) {
        Timer(Durations.medium4,(){
          Navigator.pushNamed(context, '/noInternet');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashLogoImageWidget(),
    );
  }
}