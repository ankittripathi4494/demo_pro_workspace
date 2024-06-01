import 'dart:io';

import 'package:demoproapp/global_widget/app_drawer.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          showDialog(context: context, builder:(context) {
            return AlertDialog(
              title: const Text("Do You want to close the app?"),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                  onPressed:() {
                  exit(0);
                }, child: const Text("Yes")),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                  onPressed:() {
                  Navigator.pop(context);
                }, child: const Text("No")),
              ],
            );
          },);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        drawer: MyDrawer.getDrawer(context),
        body: const Center(child: Text("Dashboard Screen"),),
      ),
    );
  }
}