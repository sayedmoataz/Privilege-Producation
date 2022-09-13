import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BuyWebView extends StatefulWidget {
  const BuyWebView({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<BuyWebView> createState() => _BuyWebViewState();
}

class _BuyWebViewState extends State<BuyWebView> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      zoomEnabled: true,
      initialUrl: widget.url,
    );
  }
}
