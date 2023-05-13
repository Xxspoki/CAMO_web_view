import 'package:flutter/material.dart';
import 'package:web_view/webview_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Бизнес школа CAMO',
      home: WebViewScreen(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

// var controller = WebViewController()
//   ..loadRequest(Uri.parse('http://216.250.10.154/'))
//   ..setJavaScriptMode(JavaScriptMode.unrestricted);
