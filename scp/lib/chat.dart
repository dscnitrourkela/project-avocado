import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:scp/utils/chatArgs.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChatArguments args = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: WebviewScaffold(
        url:args.url,
        withZoom: true,
        hidden: true,
        withJavascript: true,
        resizeToAvoidBottomInset: true,
        initialChild: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
