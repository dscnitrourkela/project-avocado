import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> isInternetAvailable() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      return Future.value(true);
    }
  } on SocketException catch (_) {
    print('not connected');
  }

  return Future.value(false);
}

void showNoInternetAvailableSnackbar(GlobalKey<ScaffoldState> scaffoldKey) {
  scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Text("There's no internet connection"),
    duration: Duration(seconds: 30),
  ));
}
