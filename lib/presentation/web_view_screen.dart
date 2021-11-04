import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget
{
  final String url;

  WebViewScreen(this.url);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
   appBar: AppBar(),
      body: SafeArea(
        child: WebView(
          initialUrl: url,
          onPageStarted: (String string){
            print(string);

          },
          allowsInlineMediaPlayback: true,
          gestureNavigationEnabled: true,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}