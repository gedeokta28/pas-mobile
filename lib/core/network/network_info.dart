import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    switch (result) {
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.none:
        return false;
      case ConnectivityResult.vpn:
        return true;
      case ConnectivityResult.other:
        // TODO: Handle this case.
        return false;
    }
  }
}
