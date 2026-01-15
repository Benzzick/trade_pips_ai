import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/core/controllers/user_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/settings/custom_toggle_widget.dart';
import 'package:trade_pips_ai_flutter/presentation/settings/settings_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/settings/user_details_widget.dart';
import 'package:trade_pips_ai_flutter/core/widgets/notifications_icon_button.dart';
import 'package:trade_pips_ai_flutter/routes/app_pages.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
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
                            "Settings",
                            style: TextStyle(
                              fontSize: 22,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Manage your preferences",
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
                  UserDetailsWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "🔔  Push Notifications".toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        CustomToggle(
                          value:
                              userController
                                  .user
                                  .value
                                  ?.enablePushNotifications ??
                              false,
                          onChanged: (val) {
                            userController.changeUserData(
                              enablePushNotifications: val,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: AppColors.secondary,
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: 20,
                  //     vertical: 20,
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         "📰 News Updates".toUpperCase(),
                  //         style: TextStyle(
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.bold,
                  //           color: AppColors.primary,
                  //         ),
                  //       ),
                  //       CustomToggle(
                  //         value:
                  //             userController.user.value?.enableNewsUpdates ??
                  //             false,
                  //         onChanged: (val) {
                  //           userController.changeUserData(
                  //             enableNewsUpdates: val,
                  //           );
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(15),
                        ),
                        backgroundColor: Color.fromRGBO(255, 0, 0, 1),
                      ),
                      onPressed: () {
                        Get.offAndToNamed(AppRoutes.auth);
                        userController.logOut();
                      },
                      child: Text(
                        "Sign out".toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
