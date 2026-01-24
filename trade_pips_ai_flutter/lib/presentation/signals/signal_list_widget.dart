import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/core/controllers/top_snack_bar_controller.dart';
import 'package:trade_pips_ai_flutter/core/utils/time_util.dart';
import 'package:trade_pips_ai_flutter/models/signal_model.dart';
import 'package:trade_pips_ai_flutter/presentation/signals/signals_controller.dart';

class SignalListWidget extends GetView<SignalsController> {
  const SignalListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.uniqueStrategies.isEmpty) {
      return const SizedBox();
    }

    final list = controller.uniqueStrategies.values.toList();

    final safeIndex = controller.safeSelectedIndex;

    return ListView.builder(
      itemCount: list[safeIndex].length,
      itemBuilder: (context, index) {
        final color =
            controller.statBgColors[controller.safeSelectedIndex %
                controller.statBgColors.length];
        final signals = list[safeIndex];
        final signal = signals[index];

        return Column(
          children: [
            if (index > 0)
              SizedBox(
                height: 20,
              ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(15),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 9,
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/icons/charts2.png",
                              scale: 2,
                            ),
                            Text(
                              signal.direction.name.capitalizeFirst!,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  signal.pair,
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    "${controller.getStrategyAbbreviation(signal.strategy)} • ${timeAgo(signal.timeGotSignal, controller.now.value)}",
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 17,
                                vertical: 9,
                              ),
                              child: Text(
                                "${signal.probability}%",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(
                            255,
                            255,
                            255,
                            0.04,
                          ),
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 9,
                        ),
                        child: Text(
                          "${controller.probabilityLabel(signal.probability)} • +${signal.targetPips} pips",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(
                            255,
                            255,
                            255,
                            0.04,
                          ),
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 9,
                        ),
                        child: Text(
                          "${signal.timeFrame} TF",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(
                        255,
                        255,
                        255,
                        0.04,
                      ),
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 17,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Entry Price",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(
                                      255,
                                      255,
                                      255,
                                      0.54,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${signal.entryPrice}",
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.copy,
                                size: 20,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: "${signal.entryPrice}",
                                  ),
                                ).then(
                                  (value) {
                                    Get.find<TopSnackBarController>().show(
                                      message: "Copied!",
                                      success: true,
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(
                              255,
                              255,
                              255,
                              0.04,
                            ),
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            height: 14,
                            width: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    final strategyIndex = controller.safeSelectedIndex;

                    final tpIndex = controller.selectedTpIndex[strategyIndex];
                    final slIndex = controller.selectedSlIndex[strategyIndex];

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // TP
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(
                              255,
                              255,
                              255,
                              0.04,
                            ),
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 17,
                          ),
                          width:
                              (MediaQuery.of(
                                    context,
                                  ).size.width /
                                  2) -
                              40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Take Profit",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(
                                        255,
                                        255,
                                        255,
                                        0.54,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${signal.takeProfitPrice[tpIndex]}",
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.copy,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text:
                                          "${signal.takeProfitPrice[slIndex]}",
                                    ),
                                  ).then(
                                    (value) {
                                      Get.find<TopSnackBarController>().show(
                                        message: "Copied!",
                                        success: true,
                                      );
                                    },
                                  );
                                },
                              ),
                              // Column(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     GestureDetector(
                              //       onTap: () {
                              //         if (tpIndex <
                              //             signal.takeProfitPrice.length - 1) {
                              //           controller.selectedTpIndex[controller
                              //                   .safeSelectedIndex] +=
                              //               1;
                              //         }
                              //       },
                              //       child: Image.asset(
                              //         "assets/icons/up.png",
                              //         scale: 2,
                              //       ),
                              //     ),
                              //     SizedBox(height: 15),
                              //     GestureDetector(
                              //       onTap: () {
                              //         if (tpIndex > 0) {
                              //           controller.selectedTpIndex[controller
                              //                   .safeSelectedIndex] -=
                              //               1;
                              //         }
                              //       },
                              //       child: Transform.rotate(
                              //         angle: 3.1416,
                              //         child: Image.asset(
                              //           "assets/icons/up.png",
                              //           scale: 2,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),

                        // SL
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(
                              255,
                              255,
                              255,
                              0.04,
                            ),
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 17,
                          ),
                          width:
                              (MediaQuery.of(
                                    context,
                                  ).size.width /
                                  2) -
                              40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Stop Loss",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(
                                        255,
                                        255,
                                        255,
                                        0.54,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${signal.stopLossPrice[slIndex]}",
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.copy,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: "${signal.stopLossPrice[slIndex]}",
                                    ),
                                  ).then(
                                    (value) {
                                      Get.find<TopSnackBarController>().show(
                                        message: "Copied!",
                                        success: true,
                                      );
                                    },
                                  );
                                },
                              ),
                              // Column(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     GestureDetector(
                              //       onTap: () {
                              //         if (slIndex <
                              //             signal.stopLossPrice.length - 1) {
                              //           controller.selectedSlIndex[controller
                              //                   .safeSelectedIndex] +=
                              //               1;
                              //         }
                              //       },
                              //       child: Image.asset(
                              //         "assets/icons/up.png",
                              //         scale: 2,
                              //       ),
                              //     ),
                              //     SizedBox(height: 15),
                              //     GestureDetector(
                              //       onTap: () {
                              //         if (slIndex > 0) {
                              //           controller.selectedSlIndex[controller
                              //                   .safeSelectedIndex] -=
                              //               1;
                              //         }
                              //       },
                              //       child: Transform.rotate(
                              //         angle: 3.1416,
                              //         child: Image.asset(
                              //           "assets/icons/up.png",
                              //           scale: 2,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(15),
                        ),
                      ),
                      onPressed: () => showCustomBottomModal(
                        context,
                        signal,
                        controller.selectedSlIndex[controller
                            .safeSelectedIndex],
                      ),
                      child: Text(
                        "Risk Management",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (index == signals.length - 1)
              SizedBox(
                height: 20,
              ),
          ],
        );
      },
    );
  }

  void showCustomBottomModal(
    BuildContext context,
    SignalModel signal,
    int slIndex,
  ) {
    controller.balanceCtrl.clear();
    controller.riskCtrl.clear();
    controller.calculatedLotSize.value = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2,
                sigmaY: 2,
              ),
              child: Container(
                color: Colors.black.withAlpha(0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Container(
                    height: 320,
                    width: 440,
                    margin: EdgeInsets.only(top: 279.5),
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 142,
                          height: 7,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Risk Management Setup",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40),
                        SizedBox(
                          height: 55,
                          child: TextField(
                            controller: controller.balanceCtrl,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 13, color: Colors.black),
                            onChanged: (_) => controller.calculateLotSize(
                              signal: signal,
                              slIndex: slIndex,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Account Balance',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                              suffixIcon: Image.asset(
                                'assets/icons/money.png',
                                scale: 2,
                              ),
                              filled: true,
                              fillColor: AppColors.primary,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromRGBO(3, 1, 29, 0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 55,
                          child: TextField(
                            controller: controller.riskCtrl,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 13, color: Colors.black),
                            onChanged: (_) => controller.calculateLotSize(
                              signal: signal,
                              slIndex: slIndex,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Risk Percentage',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                              suffixIcon: Image.asset(
                                'assets/icons/percent.png',
                                scale: 2,
                              ),
                              filled: true,
                              fillColor: AppColors.primary,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromRGBO(3, 1, 29, 0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Obx(
                          () => Text(
                            'USE: ${controller.calculatedLotSize.value} LOT SIZE',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(30, 255, 0, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
