import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mental_health/l10n/languageProvider.dart';
import 'package:mental_health/widget/Appcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class WebViewScreen extends StatefulWidget {
  String url;

  WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  String _currentLanguage = 'en';

  @override
  void initState() {
    super.initState();

    // Enable hybrid composition for Android
    if (Platform.isAndroid) {
      AndroidWebViewController;
    }

    // Initialize WebView and language preferences
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString('language_code') ?? 'en';

    // Initialize WebViewController
    _controller = WebViewController();

    // Set JavaScript Mode and Navigation Delegate for WebView
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Error occurred: ${error.description}');
          },
        ),
      );

    // Load the initial URL in WebView
    _controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          elevation: 0,
          backgroundColor: AppColors.ecogreen,
          title: Text(
            languageProvider.translate('Webview'),
            style: TextStyle(
              fontFamily: 'SourceSansPro',
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: WebViewWidget(controller: _controller), // Display the WebView with controller
    );
  }
}
