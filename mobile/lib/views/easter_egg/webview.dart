
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/* Pertemuan 15
- Web View */
class WebviewShowcasePage extends StatefulWidget {
  const WebviewShowcasePage({super.key});

  @override
  State<WebviewShowcasePage> createState() => _WebviewShowcasePageState();
}

class _WebviewShowcasePageState extends State<WebviewShowcasePage> {
  late final WebViewController _webview;
  bool loading = false;

  @override
  void initState(){
    super.initState();
    _webview = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => loading = true);
          },
          onPageFinished: (url) {
            setState(() => loading = false);
          }
        )
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://codelabs.developers.google.com/codelabs/flutter-webview'));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Demonstrasi WebView")),
      body: Scaffold(
        body: !loading ? WebViewWidget(
          controller: _webview,
        ) : const Center(child: CircularProgressIndicator())
      )
    );
  }
}