import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  var isConnected = true.obs;
  late StreamSubscription _subscription;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();

    // ✅ Handle the new List<ConnectivityResult> format
    _subscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> resultList,
    ) {
      if (resultList.isNotEmpty) {
        _updateConnectionStatus(resultList.first);
      } else {
        isConnected.value = false;
      }
    });
  }

  Future<void> _checkInitialConnection() async {
    try {
      final List<ConnectivityResult> resultList = await _connectivity
          .checkConnectivity();
      if (resultList.isNotEmpty) {
        _updateConnectionStatus(resultList.first);
      } else {
        isConnected.value = false;
      }
    } catch (_) {
      isConnected.value = false;
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    isConnected.value = result != ConnectivityResult.none;
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
