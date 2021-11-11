import 'package:flutter/material.dart';
import 'package:scp/utils/chatArgs.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChatArguments args = ModalRoute.of(context).settings.arguments;
    return SafeArea(
        child: Scaffold(
      body: WebView(
          initialUrl: args.url,
          javascriptMode: JavascriptMode.unrestricted,
          zoomEnabled: true,
          onWebResourceError: (error) {
            print(error.errorCode);
            return CircularProgressIndicator();
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          }),
    ));
  }
}
