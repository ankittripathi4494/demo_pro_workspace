// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:demoproapp/global_bloc/cubit/internet_cubit.dart';
import 'package:demoproapp/image_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../global_bloc/cubit/internet_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Nal ki toti
StreamController userStreamController =
    StreamController.broadcast(); // stream for multiple chat
StreamController passwordStreamController =
    StreamController.broadcast(); // stream for single chat
// Paani
Stream userStream = userStreamController.stream;
Stream passwordStream = passwordStreamController.stream;

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;
  TextEditingController userFormController = TextEditingController();
  TextEditingController passwordFormController = TextEditingController();

  final String userContact = "6392216480";
  final String userpassword = "Ankit@123";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    userFormController.dispose();
    passwordFormController.dispose();
    userStreamController.close();
    passwordStreamController.close();
    super.dispose();
  }
 redirectPageNetworkConnect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("isLoggedIn") == true) {
      Navigator.pushNamed(context, '/dashboard');
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocListener<InternetCubit, InternetState>(
     listener: (context, state) {
        if (state == InternetState.internetAvailable) {
          redirectPageNetworkConnect();
        }
        if (state == InternetState.internetLost) {
          Navigator.pushNamed(context, '/noInternet');
        }
      },
      child: Scaffold(
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
                        height: (snapshot.hasError) ? 80 : 60,
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
                    ),
                    // password form field
                    StreamBuilder<dynamic>(
                        stream: passwordStreamController.stream,
                        builder: (context, snapshot) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: (snapshot.hasError) ? 80 : 60,
                            child: Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    controller: passwordFormController,
                                    enabled: true,
                                    obscureText: hidePassword,
                                    obscuringCharacter: '*',
                                    onChanged: (value) {
                                      if (passwordFormController.text.length <
                                          8) {
                                        passwordStreamController.sink.addError(
                                            "Please enter password more than 7 digits");
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
                                                    hidePassword =
                                                        !hidePassword;
                                                  });
                                                },
                                                icon: const Icon(
                                                    Icons.visibility))
                                            : IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    hidePassword =
                                                        !hidePassword;
                                                  });
                                                },
                                                icon: const Icon(
                                                    Icons.visibility_off)),
                                        suffixIconColor: Colors.white,
                                        labelText: "Password",
                                        labelStyle: const TextStyle(
                                            color: Colors.white),
                                        errorText: (snapshot.hasError)
                                            ? snapshot.error.toString()
                                            : null,
                                        errorBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 2)),
                                        disabledBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 2)),
                                        enabledBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 2)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(color: Colors.white, width: 2)),
                                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Colors.white, width: 2))),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    StreamBuilder<dynamic>(
                        stream: userStream,
                        builder: (context, snapshot) {
                          return StreamBuilder<dynamic>(
                              stream: passwordStream,
                              builder: (context, snapshot2) {
                                if ((snapshot.hasData) && (snapshot2.hasData)) {
                                  return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      height: 60,
                                      child: OutlinedButton.icon(
                                        style: OutlinedButton.styleFrom(
                                            backgroundColor: Colors.deepPurple,
                                            foregroundColor: Colors.white),
                                        onPressed: () async {
                                          if ((userFormController.text
                                                      .compareTo(userContact) ==
                                                  0) &&
                                              ((passwordFormController.text
                                                      .compareTo(
                                                          userpassword) ==
                                                  0))) {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setBool("isLoggedIn", true);
                                            prefs.setString("username",
                                                userFormController.text);
                                            Navigator.pushReplacementNamed(
                                                context, '/dashboard');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    duration: Durations.long1,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin: EdgeInsets.all(10),
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                      "Login Successfull",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )));
                                          } else if ((userFormController.text
                                                      .compareTo(userContact) ==
                                                  0) &&
                                              ((passwordFormController.text
                                                      .compareTo(
                                                          userpassword) !=
                                                  0))) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    duration: Durations.long1,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin: EdgeInsets.all(10),
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                      "Password is incorrect",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )));
                                          } else if ((userFormController.text
                                                      .compareTo(userContact) !=
                                                  0) &&
                                              ((passwordFormController.text
                                                      .compareTo(
                                                          userpassword) ==
                                                  0))) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    duration: Durations.long1,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin: EdgeInsets.all(10),
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                      "Username is incorrect",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    duration: Durations.long1,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin: EdgeInsets.all(10),
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                      "Username and Password both are incorrect",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )));
                                          }
                                        },
                                        label: const Text("Submit"),
                                        icon: const Icon(
                                            Icons.present_to_all_sharp),
                                      ));
                                }
                                return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    height: 60,
                                    child: OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.grey,
                                          foregroundColor: Colors.white),
                                      onPressed: null,
                                      label: const Text("Submit"),
                                      icon: const Icon(
                                          Icons.present_to_all_sharp),
                                    ));
                              });
                        })
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
