// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:demoproapp/global_bloc/cubit/internet_cubit.dart';
import 'package:demoproapp/global_bloc/cubit/internet_state.dart';
import 'package:demoproapp/global_widget/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Do You want to close the app?"),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        exit(0);
                      },
                      child: const Text("Yes")),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No")),
                ],
              );
            },
          );
        }
      },
      child: BlocListener<InternetCubit, InternetState>(
       listener: (context, state) {
        if (state == InternetState.internetAvailable) {
          redirectPageNetworkConnect();
        }
        if (state == InternetState.internetLost) {
          Navigator.pushNamed(context, '/noInternet');
        }
      },
        child: Scaffold(
          appBar: AppBar(),
          drawer: MyDrawer.getDrawer(context),
          body: const Center(
            child: Text("Dashboard Screen"),
          ),
        ),
      ),
    );
  }
}
