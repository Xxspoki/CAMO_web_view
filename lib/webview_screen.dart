import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  PullToRefreshController? refreshController;
  InAppWebViewGroupOptions groupOptions = InAppWebViewGroupOptions(
    android: AndroidInAppWebViewOptions(),
  );
  PullToRefreshOptions pullToRefreshOptions = PullToRefreshOptions(
    color: Colors.blue,
  );
  bool pullToRefreshEnabled = true;
  double progress = 0;
  late var url;
  var initialRoute = 'online.worldsamo.com';
  var urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    refreshController = kIsWeb
        ? null
        : PullToRefreshController(
            options: pullToRefreshOptions,
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (await webViewController!.canGoBack()) {
            webViewController!.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 28),
              Expanded(
                child: Container(
                  child: InAppWebView(
                    key: webViewKey,
                    initialUrlRequest: URLRequest(url: Uri.https(initialRoute)),
                    pullToRefreshController: refreshController,
                    onWebViewCreated: (InAppWebViewController controller) {
                      webViewController = controller;
                    },
                    onLoadStop: (controller, url) {
                      refreshController?.endRefreshing();
                    },
                    onLoadError: (controller, url, code, message) {
                      refreshController?.endRefreshing();
                    },
                    onProgressChanged: (controller, progress) {
                      if (progress == 100) {
                        refreshController?.endRefreshing();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// child: Container(
//   margin: EdgeInsets.only(top: 28),
//   child: InAppWebView(
//     onWebViewCreated: (controller) => webViewController = controller,
//     initialUrlRequest: URLRequest(
//       url: Uri.http(initialRoute),
//     ),
//   ),
// ),