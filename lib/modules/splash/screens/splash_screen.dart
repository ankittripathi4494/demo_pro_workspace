// ignore_for_file: use_build_context_synchronously

import 'package:demoproapp/global_bloc/cubit/internet_cubit.dart';
import 'package:demoproapp/modules/splash/widgets/splash_logo_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../global_bloc/cubit/internet_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state == InternetState.internetAvailable) {
          redirectPageNetworkConnect();
        }
        if (state == InternetState.internetLost) {
          Navigator.pushNamed(context, '/noInternet');
        }
      },
      child: const Scaffold(
        body: SplashLogoImageWidget(),
      ),
    );
  }
}
