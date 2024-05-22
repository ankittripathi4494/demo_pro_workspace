import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../widgets/internet_not_found_image_widget.dart';

class InternetNotFoundScreen extends StatefulWidget {
  const InternetNotFoundScreen({super.key});

  @override
  State<InternetNotFoundScreen> createState() => _InternetNotFoundScreenState();
}

class _InternetNotFoundScreenState extends State<InternetNotFoundScreen> {

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
          Navigator.pushReplacementNamed(context, '/noInternet');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: InternetNotFoundImageWidget(),
    );
  }
}