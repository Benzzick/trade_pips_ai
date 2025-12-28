import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/presentation/subscribe/plan_card_widget.dart';
import 'package:trade_pips_ai_flutter/presentation/subscribe/subscribe_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/subscribe/tut_video_player.dart';

class SubscribeScreen extends GetView<SubscribeController> {
  const SubscribeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: -200,
            top: -200,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 150,
                sigmaY: 150,
              ),
              child: Container(
                width: 400,
                height: 400,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(91, 255, 255, 255),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              width: double.infinity,
              height: 158,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-0.28, -1), // approximate for 97.88deg
                  end: Alignment(1.04, 1.0),
                  colors: [
                    Color(0xFF031A34),
                    Color(0xFF1A4B82),
                  ],
                  stops: [0.0, 1.0],
                ),
                borderRadius: BorderRadius.zero,
                border: Border(
                  bottom: BorderSide(width: 5, color: AppColors.primary),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              'assets/icons/flowing.png',
              scale: 2,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: controller.subModel.value == null
                  ? Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                          ),
                          onPressed: controller.loadSubModel,
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Subscribe to TradePips",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Unlock unlimited access to premium Live Signals",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Row(),
                          ],
                        ),
                        SizedBox(
                          height: 65,
                        ),
                        Text(
                          controller.tutYTVideoHeader.value,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TutVideoPlayer(
                          videoId: controller.tutYTVideoId.value,
                        ),
                        SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 35,
                              ),
                              PlanCard(
                                planName: controller.subModel.value!.subName,
                                price: controller.subModel.value!.price
                                    .toString(),
                                duration: controller.subModel.value!.duration,
                                thingsToGet:
                                    controller.subModel.value!.thingsToGet,
                                onSubscribe: controller.subscribe,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
