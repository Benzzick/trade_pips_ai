import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/core/utils/time_util.dart';
import 'package:trade_pips_ai_flutter/presentation/news/news_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/news/news_modal.dart';
import 'package:trade_pips_ai_flutter/widgets/no_items_widget.dart';

class NewsWidget extends GetView<NewsController> {
  const NewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.newsList.isEmpty
        ? NoItemsWidget(text: "There are currently no news!")
        : ListView.builder(
            itemCount: controller.newsList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  if (index > 0)
                    SizedBox(
                      height: 20,
                    ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                    ),
                    onPressed: () {
                      showCustomBottomModal(
                        context,
                        controller.newsList[index],
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 0, 0, 0.99),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 9,
                              width: 9,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Obx(
                              () => Text(
                                "${controller.newsList[index].impact.name.capitalizeFirst!} Impact • ${timeAgo(controller.newsList[index].time, controller.now.value)}",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          controller.newsList[index].title,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.newsList[index].currency,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Image.asset(
                              "assets/icons/arrow.png",
                              scale: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (index == controller.newsList.length - 1)
                    SizedBox(
                      height: 20,
                    ),
                ],
              );
            },
          );
  }
}
