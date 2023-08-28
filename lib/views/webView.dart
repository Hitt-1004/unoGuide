import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewContainer extends StatefulWidget {
  final String url;

  WebViewContainer(this.url);

  @override
  createState() => _WebViewContainerState(this.url);
}

class _WebViewContainerState extends State<WebViewContainer> {
  final String url;
  final _key = UniqueKey();

  _WebViewContainerState(this.url);

  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color.fromARGB(255, 253, 244, 220))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
      ),
    )
    ..loadRequest(Uri.parse('https://unoguide.in/login'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: WebViewWidget(
              controller: controller,
            ),
      ),
    );
  }
}
