import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EDjahPage extends StatefulWidget {
  final String link;

  const EDjahPage({
    Key? key,
    required this.link,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EDjahPageState();
  }
}

class _EDjahPageState extends State<EDjahPage> {
  late WebViewController wbController;
  late String wvlnk;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    wvlnk = widget.link;
    wbController = WebViewController()
      ..loadRequest(Uri.parse(wvlnk))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 5));
    });
    _enableRotation();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await wbController.canGoBack()) {
          await wbController.goBack();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top,
            bottom: MediaQuery.of(context).viewPadding.bottom,
          ),
          child: WebViewWidget(
            controller: wbController,
          ),
        ),
      ),
    );
  }

  void _enableRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
