import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticalNews extends StatefulWidget {
  const ArticalNews({super.key, required this.newsUrl});
  final String newsUrl;
  @override
  State<ArticalNews> createState() => _ArticalNewsState();
}

class _ArticalNewsState extends State<ArticalNews> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  late bool _isLoadingPage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoadingPage = true;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('News'),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.newsUrl,
            onWebViewCreated: (WebViewController controller) {
              _completer.complete(controller);
            },
            onPageFinished: (String finish) =>
                setState(() => _isLoadingPage = false),
          ),
          if (_isLoadingPage)
            Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator(
                backgroundColor: Colors.yellow,
              ),
            )
          else
            SizedBox.shrink()
        ],
      ),
    );
  }
}
