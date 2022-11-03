import 'package:url_launcher/url_launcher.dart';

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, enableJavaScript: true, forceWebView: false);
  } else {
    throw 'Could not launch $url';
  }
}
