import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:scp/utils/chatArgs.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChatArguments args = ModalRoute.of(context).settings.arguments;
    return SafeArea(
        child: Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(args.url)),
      ),
    ));
  }
}
