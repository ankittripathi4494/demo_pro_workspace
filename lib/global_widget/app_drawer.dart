// ignore_for_file: use_build_context_synchronously

import 'package:demoproapp/image_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer {
  static Drawer getDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(ImageList.logo))),
              child: Container()),
          ListTile(
            onTap: () async {
              Navigator.pushReplacementNamed(context, '/');
            },
            title: const Text("Home"),
            leading: const Icon(Icons.home),
          ),
          ExpansionTile(
            title: const Text("Crud With database without singleton"),
            leading: const Icon(Icons.home),
            children: [
              
              ListTile(
                onTap: () async {
                  Navigator.pushReplacementNamed(context, '/crud1/read', arguments: {"title":"Student List"});
                },
                title: const Text("Crrud 1 List"),
                leading: const Icon(Icons.list),
              ),
            ],
          ),
          ListTile(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            title: const Text("Logout"),
            leading: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
