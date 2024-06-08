// ignore_for_file: use_build_context_synchronously

import 'package:demoproapp/modules/splash/widgets/splash_logo_image_widget.dart';
import 'package:duration_button/duration_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DurationButton(
              width: 1,
              height: 1,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              coverColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              onComplete: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (prefs.getBool("isLoggedIn") == true) {
                  Navigator.pushNamed(context, '/dashboard');
                } else {
                  Navigator.pushNamed(context, '/login');
                }
              },
              onPressed: () {},
              duration: Durations.medium2,
              child: Container()),
          SplashLogoImageWidget(),
        ],
      ),
    );
  }
}
