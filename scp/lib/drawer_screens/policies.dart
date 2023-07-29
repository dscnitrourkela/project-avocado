import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:scp/utils/chatArgs.dart';

class PoliciesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChatArguments args =
        ModalRoute.of(context)!.settings.arguments as ChatArguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 39, 45, 1),
        title: Text(
          "Terms & Policies",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'PfDin',
              fontWeight: FontWeight.w600),
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(args.url)),
      ),
    );
  }
}
