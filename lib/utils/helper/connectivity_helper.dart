import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityHelper extends GetxController {
  static ConnectivityHelper connectivityHelper = ConnectivityHelper._();

  ConnectivityHelper._();

  Connectivity connectivity = Connectivity();
  RxBool check = false.obs;

  void checkInternet() {
    connectivity.onConnectivityChanged.listen(
      (event) {
        if (event.contains(ConnectivityResult.none)) {
          check.value = false;
        } else {
          check.value = true;
        }
      },
    );
  }
}
