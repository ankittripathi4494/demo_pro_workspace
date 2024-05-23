import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demoproapp/image_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

      if ((result.contains(ConnectivityResult.ethernet)) ||
          (result.contains(ConnectivityResult.mobile)) ||
          (result.contains(ConnectivityResult.wifi)) ||
          (result.contains(ConnectivityResult.vpn))) {
        Timer(Durations.medium4, () {
          Navigator.pushNamed(context, '/');
        });
      } else if ((result.contains(ConnectivityResult.none))) {
        Timer(Durations.medium4, () {
          Navigator.pushNamed(context, '/noInternet');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(ImageList.backgroundImage))),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(1)),
              child: Form(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 60,
                    child: TextFormField(
                      cursorColor: Colors.transparent,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.verified_user),
                          prefixIconColor: Colors.white,
                          suffix: TextButton.icon(
                            style:TextButton.styleFrom(
                              backgroundColor: Colors.white
                            ) ,
                            onPressed: () {},
                            label: Text("Verify"),
                            icon: Icon(Icons.verified_user),
                          ),
                          labelText: "Username/E-Mail",
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: "ankit@email.com",
                          hintStyle: TextStyle(color: Colors.white),
                          helperText: null,
                          helperStyle: TextStyle(color: Colors.white),
                          errorText: null,
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2))),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 60,
                    child: TextFormField(
                      enabled: true,
                      cursorColor: Colors.transparent,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          prefixIconColor: Colors.white,
                          suffixIcon: Icon(Icons.visibility_off),
                          suffixIconColor: Colors.white,
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: "ankit@123",
                          hintStyle: TextStyle(color: Colors.white),
                          errorText: null,
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2))),
                    ),
                  )
                ],
              )),
            ),
          )
        ],
      ),
    );
  }
}
