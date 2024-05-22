import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          Navigator.pushNamed(context, '/');
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
      body: Center(child: Text("Login Screen"),),
    );
  }
}

