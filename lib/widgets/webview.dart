import 'package:flutter/material.dart';
import 'package:flutter_trip/lib/parse_color.dart';
import 'package:webview_flutter/webview_flutter.dart' as WebviewFlutter;
import 'package:webview_flutter/webview_flutter.dart';

const catchUrls = [
  'm.ctrip.com/',
  'm.ctrip.com/html5/',
  'm.ctrip.com/html5'
]; // webview 導向白名單

class WebView extends StatefulWidget {
  final String url;
  final String? statusBarColor;
  final String? title;
  final bool? hideAppBar;
  final bool backForbid;

  const WebView({
    Key? key,
    required this.url,
    this.statusBarColor,
    this.title,
    this.hideAppBar = false,
    this.backForbid = false,
  }) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    String _statusBarColor = widget.statusBarColor ?? 'ffffff';
    Color _backButtonColor =
        _statusBarColor == 'ffffff' ? Colors.black : Colors.white;
    bool exiting = false; // 防止兩次返回

    _isToMain(String url) {
      for (final value in catchUrls) {
        if (url.endsWith(value)) {
          return true;
        }
      }
      return false;
    }

    // 用來改變 webview 返回鍵的調用模式
    _navigationDelegate(NavigationRequest request) {
      if (!exiting && _isToMain(request.url)) {
        if (widget.backForbid) {
          return NavigationDecision.prevent; // 保持當前頁
        } else {
          Navigator.pop(context);
          exiting = true;
        }
      }
      return NavigationDecision.navigate; // 導向任意頁面
    }

    return Scaffold(
      body: Column(
        children: [
          _appBar(
            parseColor(_statusBarColor),
            _backButtonColor,
          ),
          Expanded(
            child: WebviewFlutter.WebView(
              navigationDelegate: _navigationDelegate,
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? true) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return FractionallySizedBox(
      widthFactor: 1, // 稱滿屏幕寬度
      child: Stack(
        children: [
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.close,
                color: backButtonColor,
                size: 26,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                widget.title ?? '',
                style: TextStyle(
                  color: backButtonColor,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
