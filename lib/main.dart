import 'package:ele_mob_app/htmlcontent.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

const String url = "https://www.youtube.com/";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print("Website progress $progress");
          },
          onPageStarted: (String url) {
            print("$url started Loading");
          },
          onPageFinished: (String url) {
            print("$url finished Loading");
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      // ..loadRequest(Uri.parse(url));
      ..loadRequest(Uri.dataFromString(html, mimeType: "text/html"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Testing'),
      ),
      body: WebViewWidget(controller: controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("button got pressed");
          const String javascripSnipet =
              "document.getElementById('normainput').value = 'Hello world';";
          const String javascripSubmitButton =
              "document.getElementById('btnid').click()";
          var data =
              await controller.runJavaScriptReturningResult(javascripSnipet);
          print(data);
          print(data.runtimeType);
          var data2 = await controller
              .runJavaScriptReturningResult(javascripSubmitButton);
          print("Exec Ended");
          print(data2);
          print(data2.runtimeType);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.toys),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
