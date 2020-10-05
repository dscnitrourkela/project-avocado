import 'dart:async';

import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  StreamController<ConnectionStatus> connectivityController =
      StreamController<ConnectionStatus>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult status) {
      var _connectionStatus = _networkStatus(status);

      connectivityController.add(_connectionStatus);
    });
  }

  ConnectionStatus _networkStatus(ConnectivityResult status) {
    switch (status) {
      case ConnectivityResult.mobile:
        return ConnectionStatus.mobileData;

      case ConnectivityResult.wifi:
        return ConnectionStatus.wifi;

      case ConnectivityResult.none:
        return ConnectionStatus.offline;

      default:
        return ConnectionStatus.offline;
    }
  }
}

enum ConnectionStatus {
  wifi,
  mobileData,
  offline,
}

final ConnectivityService connectivityService = ConnectivityService();
