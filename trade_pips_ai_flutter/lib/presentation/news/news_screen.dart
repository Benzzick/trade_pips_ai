import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/core/utils/time_util.dart';
import 'package:trade_pips_ai_flutter/presentation/news/news_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/news/news_modal.dart';
import 'package:trade_pips_ai_flutter/presentation/news/news_widget.dart';
import 'package:trade_pips_ai_flutter/core/widgets/notifications_icon_button.dart';

class NewsScreen extends GetView<NewsController> {
  const NewsScreen({super.key});

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
        SafeArea(
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
                          "Market News",
                          style: TextStyle(
                            fontSize: 22,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Stay updated with forex markets",
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
                if (controller.breakingNews.value != null) ...[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    clipBehavior: Clip.hardEdge,
                    onPressed: () {
                      showCustomBottomModal(
                        context,
                        controller.breakingNews.value!,
                      );
                    },
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/images/fxchart.png",
                        ),
                        Positioned.fill(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 0, 0, 0.99),
                                    borderRadius: BorderRadius.circular(
                                      30,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 17,
                                    vertical: 9,
                                  ),
                                  child: Text(
                                    "Breaking".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(30, 255, 0, 1),
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
                                        timeAgo(
                                          controller.breakingNews.value!.time,
                                          controller.now.value,
                                        ),
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  controller.breakingNews.value!.title,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  controller.breakingNews.value!.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
                Expanded(child: NewsWidget()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
