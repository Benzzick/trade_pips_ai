import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/presentation/signals/signals_controller.dart';

class StatWidget extends GetView<SignalsController> {
  const StatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ListView.builder(
        itemCount: controller.todaystats.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SizedBox(
                width: index == 0 ? 0 : 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: controller
                      .statBgColors[index % controller.statBgColors.length]
                      .withAlpha(26),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: .3,
                    color: controller
                        .statBgColors[index % controller.statBgColors.length],
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: (MediaQuery.of(context).size.width / 3) - 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.todaystats[index].numberPercent,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color:
                            controller.statBgColors[index %
                                controller.statBgColors.length],
                      ),
                    ),
                    Text(
                      controller.todaystats[index].title,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
