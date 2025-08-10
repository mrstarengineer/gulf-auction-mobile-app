import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../global/global.dart';

class WebPreviewPage extends StatelessWidget {
  const WebPreviewPage({super.key});

  Future<WebViewController> _createController(String url) async {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    final url = Get.arguments;
    return Scaffold(
      appBar: AppBars.appBar(title: 'Terms & Condition'),
      body: FutureBuilder<WebViewController>(
        future: _createController(url),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return WebViewWidget(controller: snapshot.data!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
