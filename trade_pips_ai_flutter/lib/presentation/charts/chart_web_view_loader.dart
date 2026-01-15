import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';

class ChartWebViewLoader extends StatefulWidget {
  final String html;
  const ChartWebViewLoader({super.key, required this.html});

  @override
  State<ChartWebViewLoader> createState() => _ChartWebViewLoaderState();
}

class _ChartWebViewLoaderState extends State<ChartWebViewLoader> {
  bool _isLoading = true;
  bool _hasError = false;

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) {
              setState(() => _isLoading = false);
            }
          },
          onWebResourceError: (_) {
            if (mounted) {
              setState(() {
                _isLoading = false;
                _hasError = true;
              });
            }
          },
          onNavigationRequest: (_) => NavigationDecision.prevent,
        ),
      )
      ..loadHtmlString(widget.html);
  }

  void _retry() {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    _controller.loadHtmlString(widget.html);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // WEBVIEW (always bottom layer)
        Positioned.fill(
          child: WebViewWidget(controller: _controller),
        ),

        // LOADING OVERLAY
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.white, // full cover
              child: Center(
                child: SizedBox(
                  height: 36,
                  width: 36,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: AppColors.secondary,
                    strokeCap: StrokeCap.round,
                  ),
                ),
              ),
            ),
          ),

        // ERROR OVERLAY
        if (_hasError)
          Positioned.fill(
            child: Container(
              color: Colors.white, // full cover
              child: Center(
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                    ),
                    onPressed: _retry,
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: const Text(
                      "Reload chart",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
