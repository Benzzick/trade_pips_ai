import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/presentation/signals/signals_controller.dart';

class StrategyHeaderWidget extends GetView<SignalsController> {
  const StrategyHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ListView.builder(
        itemCount: controller.uniqueStrategies.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final strategy = controller.uniqueStrategies.keys.toList()[index];
          final noOfSignals = controller.uniqueStrategies.values
              .toList()[index]
              .length;
          final color =
              controller.statBgColors[index % controller.statBgColors.length];
          return Row(
            children: [
              SizedBox(
                width: index == 0 ? 0 : 15,
              ),
              GestureDetector(
                onTap: () {
                  controller.selectedSignalIndex.value = index;
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(15),
                    border: controller.selectedSignalIndex.value == index
                        ? Border.all(
                            width: 1,
                            color: Color.fromRGBO(
                              255,
                              255,
                              255,
                              0.44,
                            ),
                          )
                        : null,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: (MediaQuery.of(context).size.width / 2) - 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.getStrategyAbbreviation(
                              strategy,
                            ),
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color:
                                  controller.statBgColors[index %
                                      controller.statBgColors.length],
                            ),
                          ),
                          Text(
                            "$noOfSignals ${noOfSignals > 1 ? "Signals" : "Signal"}",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 9,
                        width: 9,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
