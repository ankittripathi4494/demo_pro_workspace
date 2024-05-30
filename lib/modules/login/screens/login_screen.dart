import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demoproapp/image_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Nal ki toti
StreamController userStreamController = StreamController();
StreamController passwordStreamController = StreamController();
// Paani
Stream userStream = userStreamController.stream;
Stream passwordStream = passwordStreamController.stream;

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;
  TextEditingController userFormController = TextEditingController();
  TextEditingController passwordFormController = TextEditingController();
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
  void dispose() {
   userFormController.dispose();
   passwordFormController.dispose();
   userStreamController.close();
   passwordStreamController.close();
    super.dispose();
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
                  // User form field
                  StreamBuilder<dynamic>(
                    stream: userStreamController.stream,
                    builder: (context, snapshot) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: (snapshot.hasError)?80:60,
                      child: TextFormField(
                        controller: userFormController,
                        cursorColor: Colors.transparent,
                        style: const TextStyle(color: Colors.white),
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (userFormController.text.length < 10) {
                            userStreamController.sink.addError(
                                "Please enter phone number upto 10 digts");
                          } else {
                            userStreamController.sink.add("");
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          // FilteringTextInputFormatter.allow('@')
                        ],
                        decoration: InputDecoration(
                            counterText: '',
                            prefixIcon: const Icon(Icons.verified_user),
                            prefixIconColor: Colors.white,
                            suffix: TextButton.icon(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {},
                              label: const Text("Verify"),
                              icon: const Icon(Icons.verified_user),
                            ),
                            labelText: "Phone",
                            labelStyle: const TextStyle(color: Colors.white),
                            helperText: null,
                            helperStyle: const TextStyle(color: Colors.white),
                            errorText: (snapshot.hasError)
                                ? snapshot.error.toString()
                                : null,
                            errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            disabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2)),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2))),
                      ),
                    ),
                  ),
                  // password form field
                  StreamBuilder<dynamic>(
                    stream: passwordStreamController.stream,
                    builder: (context, snapshot) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: (snapshot.hasError)?80:60,
                        child: Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: passwordFormController,
                                enabled: true,
                                obscureText: hidePassword,
                                obscuringCharacter: '*',
                                onChanged: (value) {
                                  if (passwordFormController.text.length<8) {
                                    passwordStreamController.sink.addError("Please enter password more than 7 digits");
                                  } else {
                                    passwordStreamController.sink.add("");
                                  }
                                },
                                cursorColor: Colors.transparent,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.password),
                                    prefixIconColor: Colors.white,
                                    suffixIcon: (hidePassword == true)
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                hidePassword = !hidePassword;
                                              });
                                            },
                                            icon: const Icon(Icons.visibility))
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                hidePassword = !hidePassword;
                                              });
                                            },
                                            icon: const Icon(Icons.visibility_off)),
                                    suffixIconColor: Colors.white,
                                    labelText: "Password",
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    errorText: (snapshot.hasError)?snapshot.error.toString():null,
                                    errorBorder: const OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 2)),
                                    disabledBorder: const OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2)),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2)),
                                    border: const OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2))),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 60,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          print("UserName :- ${userFormController.text}");
                          print("Password :- ${passwordFormController.text}");
                        },
                        label: const Text("Submit"),
                        icon: const Icon(Icons.present_to_all_sharp),
                      ))
                ],
              )),
            ),
          )
        ],
      ),
    );
  }
}
