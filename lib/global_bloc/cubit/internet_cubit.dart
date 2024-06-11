import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit() : super(InternetState.internetInitial) {
    checkNetworkConnectivity();//one time check network
    Connectivity().onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.vpn)) {
        emit(InternetState.internetAvailable);
      } else if (result.contains(ConnectivityResult.none)) {
        emit(InternetState.internetLost);
      }
    });
  }

  checkNetworkConnectivity() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.vpn)) {
      emit(InternetState.internetAvailable);
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(InternetState.internetLost);
    }
  }
}
