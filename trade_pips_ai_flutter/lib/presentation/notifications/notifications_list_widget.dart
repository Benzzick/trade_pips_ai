import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/core/utils/time_util.dart';
import 'package:trade_pips_ai_flutter/presentation/notifications/notifications_controller.dart';
import 'package:trade_pips_ai_flutter/widgets/no_items_widget.dart';

class NotificationsListWidget extends GetView<NotificationsController> {
  const NotificationsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.notifications.isEmpty
        ? NoItemsWidget(text: "There are currently no notifications!")
        : ListView.builder(
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final color = Color.fromRGBO(30, 255, 0, 1);
              final notification = controller.notifications[index];

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
                                    notification
                                        .direction
                                        .name
                                        .capitalizeFirst!,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notification.pair,
                                        style: TextStyle(
                                          color: color,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Obx(
                                        () => Text(
                                          "${controller.getStrategyAbbreviation(notification.strategy)} • ${timeAgo(notification.timeGotSignal, controller.now.value)}",
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
                                      "${notification.probability}%",
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
                                "${controller.probabilityLabel(notification.probability)} • +${notification.targetPips} pips",
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
                                "${notification.timeFrame} TF",
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
                                    "${notification.entryPrice}",
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                        Row(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        "${notification.takeProfitPrice}",
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        "${notification.stopLossPrice}",
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (index == controller.notifications.length - 1)
                    SizedBox(
                      height: 20,
                    ),
                ],
              );
            },
          );
  }
}
