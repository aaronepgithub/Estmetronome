import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewInFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://www.curesma.org/',
      // hidden: true,
      // appBar: AppBar(title: Text("Inducesmile.com")),
    );
  }
}