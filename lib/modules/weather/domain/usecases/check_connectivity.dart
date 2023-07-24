import 'package:connectivity_plus/connectivity_plus.dart';

abstract class CheckConnectivity {
  Future<bool> call();
}

class CheckConnectivityImpl implements CheckConnectivity {

  Future<bool> call() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }

}