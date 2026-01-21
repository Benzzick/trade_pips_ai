import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';

class PaystackScreen extends StatefulWidget {
  final String url;

  const PaystackScreen({super.key, required this.url});

  @override
  State<PaystackScreen> createState() => _PaystackScreenState();
}

class _PaystackScreenState extends State<PaystackScreen> {
  late final WebViewController controller;

  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = "".obs;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    hasError.value = false;
    isLoading.value = true;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            isLoading.value = true;
          },
          onPageFinished: (_) {
            isLoading.value = false;
          },
          onWebResourceError: (error) {
            print("WEBVIEW ERROR: ${error.description}");

            isLoading.value = false;
            hasError.value = true;
            errorMessage.value = error.description;
          },
          onNavigationRequest: (request) {
            final url = request.url;
            print("PAYSTACK URL: $url");

            if (url.contains("callback") || url.contains("success")) {
              Get.back(result: true);
              return NavigationDecision.prevent;
            }

            if (url.contains("close") || url.contains("cancel")) {
              Get.back(result: false);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔵 Background blur
          Positioned(
            left: -200,
            top: -200,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
              child: Container(
                width: 400,
                height: 400,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(55, 255, 255, 255),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  /// 🔷 Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Subscription",
                            style: TextStyle(
                              fontSize: 22,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Complete your payment",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: AppColors.primary),
                        onPressed: () => Get.back(result: false),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// 🧾 WebView Card
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          /// WebView
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: WebViewWidget(controller: controller),
                          ),

                          /// ⏳ Loading
                          Obx(
                            () => isLoading.value
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Center(
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
                                  )
                                : const SizedBox.shrink(),
                          ),

                          /// ❌ Error UI
                          Obx(
                            () => hasError.value
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.wifi_off,
                                            size: 60,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(height: 12),
                                          const Text(
                                            "Failed to load payment page",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            "Network Error",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            height: 45,
                                            child: ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.secondary,
                                              ),
                                              onPressed: _initWebView,
                                              icon: const Icon(
                                                Icons.refresh,
                                                color: Colors.white,
                                              ),
                                              label: const Text(
                                                "Retry",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
