import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              title: Text("Do You want to close the app?"),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                  onPressed:() {
                  exit(0);
                }, child: Text("Yes")),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                  onPressed:() {
                  Navigator.pop(context);
                }, child: Text("No")),
              ],
            );
          },);
        }
      },
      child: Scaffold(
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Dashboard Screen"),
             ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                  onPressed:() async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                   Navigator.pushReplacementNamed(
                                                    context, '/login');
                }, child: Text("Logout")),
          ],
        ),),
      ),
    );
  }
}