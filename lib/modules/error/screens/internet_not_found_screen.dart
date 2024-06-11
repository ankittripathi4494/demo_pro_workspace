// ignore_for_file: use_build_context_synchronously

import 'package:demoproapp/global_bloc/cubit/internet_cubit.dart';
import 'package:demoproapp/global_bloc/cubit/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/internet_not_found_image_widget.dart';

class InternetNotFoundScreen extends StatefulWidget {
  const InternetNotFoundScreen({super.key});

  @override
  State<InternetNotFoundScreen> createState() => _InternetNotFoundScreenState();
}

class _InternetNotFoundScreenState extends State<InternetNotFoundScreen> {
  @override
  void initState() {
    super.initState();
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
        body: InternetNotFoundImageWidget(),
      ),
    );
  }
}
