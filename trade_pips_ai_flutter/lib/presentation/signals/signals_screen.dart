import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/presentation/signals/signal_list_widget.dart';
import 'package:trade_pips_ai_flutter/presentation/signals/signals_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/signals/stat_widget.dart';
import 'package:trade_pips_ai_flutter/presentation/signals/strategy_header_widget.dart';
import 'package:trade_pips_ai_flutter/widgets/no_items_widget.dart';
import 'package:trade_pips_ai_flutter/widgets/notifications_icon_button.dart';

class SignalsScreen extends GetView<SignalsController> {
  const SignalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                color: Color.fromARGB(55, 255, 255, 255),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Obx(
          () => SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Signals",
                            style: TextStyle(
                              fontSize: 22,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${controller.signals.length} active • Live feed",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      NotificationsIconButton(),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  StatWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trading Strategies".toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Tooltip(
                        message:
                            "This is the ${controller.uniqueStrategies.keys.toList()[controller.selectedSignalIndex.value]} strategy",
                        triggerMode: TooltipTriggerMode.tap, // 👈 show on tap
                        preferBelow: false,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/info.png",
                              scale: 2,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "Info",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (controller.signals.isEmpty)
                    NoItemsWidget(text: "There are currently no signals!")
                  else ...[
                    SizedBox(
                      height: 20,
                    ),
                    StrategyHeaderWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Live Signals".toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color:
                                    controller.statBgColors[controller
                                            .selectedSignalIndex
                                            .value %
                                        controller.statBgColors.length],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 9,
                              width: 9,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "In Real Time",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(child: SignalListWidget()),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
