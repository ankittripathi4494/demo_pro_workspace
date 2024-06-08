import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'global_bloc/cubit/internet_cubit.dart';
import 'global_bloc/cubit/internet_state.dart';
import 'myapp.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<InternetCubit>(
      create: (context) => InternetCubit(),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      bloc: InternetCubit(),
      builder: (context, state) {
        if (state == InternetState.internelAvailable) {
          return const MyApp();
        }
        return const MyAppNoInternet();
      },
    );
  }
}
