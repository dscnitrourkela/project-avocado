import 'dart:async';

import 'package:flutter/material.dart';

import './connectivity_service.dart';

// Wrap any Page or View with this widget which is needed to be monitored for the connection changes

class ConnectivityHandlerWidget extends StatefulWidget {
  final child;

  const ConnectivityHandlerWidget({Key key, this.child}) : super(key: key);
  @override
  _ConnectivityHandlerWidgetState createState() =>
      _ConnectivityHandlerWidgetState();
}

class _ConnectivityHandlerWidgetState extends State<ConnectivityHandlerWidget> {
  ConnectionStatus status;
  StreamSubscription subscription;
  BuildContext ctx;

  // This variable is just use to handle the case when the user just opens the app and is already having an internet conncetion
  // So this variable is just handling that case
  bool toDisplay = false;

  @override
  void initState() {
    super.initState();
    subscription =
        connectivityService.connectivityController.stream.listen((event) {
      status = event;
      print(status);
      if (status == ConnectionStatus.offline) {
        if (!toDisplay) {
          setState(() {
            toDisplay = true;
          });
        }
        _showSnackBar('No Internet Connection !!!');
      } else {
        if (toDisplay) _showSnackBar('Connection Established');
      }
    });
  }

  _showSnackBar(String data) {
    Scaffold.of(ctx)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            data,
            style: TextStyle(color: Colors.amber),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          ctx = context;
          return widget.child;
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }
}
