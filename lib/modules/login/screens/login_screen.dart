// ignore_for_file: use_build_context_synchronously

import 'package:demoproapp/global_bloc/cubit/internet_cubit.dart';
import 'package:demoproapp/image_list.dart';
import 'package:demoproapp/modules/login/login_bloc/login_bloc.dart';
import 'package:demoproapp/modules/login/login_bloc/login_event.dart';
import 'package:demoproapp/modules/login/login_bloc/login_state.dart';
import 'package:duration_button/duration_button.dart';
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

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;
  TextEditingController userFormController = TextEditingController();
  TextEditingController passwordFormController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    userFormController.dispose();
    passwordFormController.dispose();
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
    // var size = MediaQuery.of(context).size;
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return Form(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if (state is LoginFormSubmitSuccessState) {
                              return DurationButton(
                                  backgroundColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  coverColor: Colors.transparent,
                                  onComplete: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setBool("isLoggedIn", true);
                                    prefs.setString(
                                        "username", userFormController.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "${state.successMesaage}")));
                                    Navigator.pushReplacementNamed(
                                        context, '/dashboard');
                                  },
                                  onPressed: () {},
                                  duration: Durations.extralong3,
                                  child: Container());
                            }

                            if (state is LoginFormSubmitFailedState) {
                              return DurationButton(
                                  backgroundColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  coverColor: Colors.transparent,
                                  onComplete: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/login');
                                  },
                                  onPressed: () {},
                                  duration: Durations.extralong3,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration:
                                        const BoxDecoration(color: Colors.red),
                                    child: Text(
                                      "${(state.commonError != null) ? state.commonError : ((state.usernameError != null) ? state.usernameError : state.passwordError)}",
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ));
                            }
                            return Container();
                          },
                        ),
                        // User form field
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: (state is LoginFormTextChangeErrorState)
                              ? 80
                              : 60,
                          child: TextFormField(
                            controller: userFormController,
                            cursorColor: Colors.transparent,
                            style: const TextStyle(color: Colors.white),
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginFormTextChangeEvent(
                                      usernameValue: userFormController.text,
                                      passwordValue:
                                          passwordFormController.text));
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
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                helperText: null,
                                helperStyle:
                                    const TextStyle(color: Colors.white),
                                errorText:
                                    (state is LoginFormTextChangeErrorState)
                                        ? state.usernameError
                                        : null,
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
                        // password form field
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: (state is LoginFormTextChangeErrorState)
                              ? 80
                              : 60,
                          child: Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  controller: passwordFormController,
                                  enabled: true,
                                  obscureText: hidePassword,
                                  obscuringCharacter: '*',
                                  onChanged: (value) {
                                    BlocProvider.of<LoginBloc>(context).add(
                                        LoginFormTextChangeEvent(
                                            usernameValue:
                                                userFormController.text,
                                            passwordValue:
                                                passwordFormController.text));
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
                                              icon:
                                                  const Icon(Icons.visibility))
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  hidePassword = !hidePassword;
                                                });
                                              },
                                              icon: const Icon(
                                                  Icons.visibility_off)),
                                      suffixIconColor: Colors.white,
                                      labelText: "Password",
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      errorText: (state is LoginFormTextChangeErrorState)
                                          ? state.passwordError
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
                                      focusedBorder:
                                          const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Colors.white, width: 2)),
                                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Colors.white, width: 2))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        (state is LoginFormTextValidState)
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                height: 60,
                                child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                      foregroundColor: Colors.white),
                                  onPressed: () async {
                                    BlocProvider.of<LoginBloc>(context).add(
                                        LoginFormSubmitEvent(
                                            usernameValue:
                                                userFormController.text,
                                            passwordValue:
                                                passwordFormController.text));
                                  },
                                  label: const Text("Submit"),
                                  icon: const Icon(Icons.present_to_all_sharp),
                                ))
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                height: 60,
                                child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                      foregroundColor: Colors.white),
                                  onPressed: () async {},
                                  label: const Text("Submit"),
                                  icon: const Icon(Icons.present_to_all_sharp),
                                )),
                      ],
                    ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
