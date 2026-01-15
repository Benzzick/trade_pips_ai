import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/presentation/charts/chart_web_view_loader.dart';
import 'package:trade_pips_ai_flutter/presentation/charts/charts_controller.dart';
import 'package:trade_pips_ai_flutter/core/widgets/notifications_icon_button.dart';

class ChartsScreen extends GetView<ChartsController> {
  const ChartsScreen({super.key});

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
                            "Live Chart",
                            style: TextStyle(
                              fontSize: 22,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Real-time price action",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 38,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 17,
                          ),
                          child: DropdownButton<int>(
                            value: controller.selectedChartPairIndex.value,
                            dropdownColor: AppColors.primary,
                            iconEnabledColor: Colors.black,
                            underline: const SizedBox(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            items: List.generate(
                              controller.chartPairs.length,
                              (index) => DropdownMenuItem<int>(
                                value: index,
                                child: Text(
                                  controller.chartPairs[index].pair,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            onChanged: (int? newIndex) {
                              if (newIndex != null) {
                                controller.selectedChartPairIndex.value =
                                    newIndex;
                              }
                            },
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 9,
                        ),
                        child: Text(
                          "${controller.chartPairs[controller.selectedChartPairIndex.value].timeframe} TF",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.primary,
                      ),
                      child: Obx(
                        () => ChartWebViewLoader(
                          key: ValueKey(
                            controller.selectedChartPairIndex.value,
                          ),
                          html: controller.tradingViewHtml(
                            symbol: controller
                                .chartPairs[controller
                                    .selectedChartPairIndex
                                    .value]
                                .pair
                                .replaceAll("/", ""),
                            interval: controller
                                .chartPairs[controller
                                    .selectedChartPairIndex
                                    .value]
                                .timeframe,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Expanded(
                  //   child: Container(
                  //     clipBehavior: Clip.hardEdge,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     height: double.infinity,
                  //     child: SfCartesianChart(
                  //       backgroundColor: AppColors.primary,
                  //       plotAreaBorderWidth: 0,
                  //       primaryXAxis: DateTimeAxis(
                  //         majorGridLines: MajorGridLines(
                  //           width: 0.3,
                  //           color: Colors.grey[800],
                  //         ),
                  //         axisLine: AxisLine(width: 0),
                  //         dateFormat: DateFormat.Hm(), // Hour:Minute format
                  //         intervalType: DateTimeIntervalType.minutes,
                  //         labelStyle: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 10,
                  //         ),
                  //       ),
                  //       primaryYAxis: NumericAxis(
                  //         opposedPosition: true,
                  //         axisLine: AxisLine(width: 0),
                  //         majorTickLines: MajorTickLines(size: 0),
                  //         majorGridLines: MajorGridLines(
                  //           width: 0.3,
                  //           color: Colors.grey[800],
                  //         ),
                  //         labelStyle: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 10,
                  //         ),
                  //       ),
                  //       series: <CandleSeries>[
                  //         CandleSeries<CandleDataModel, DateTime>(
                  //           dataSource: controller.chartData,
                  //           xValueMapper: (CandleDataModel data, _) =>
                  //               data.time,
                  //           lowValueMapper: (CandleDataModel data, _) =>
                  //               data.low,
                  //           highValueMapper: (CandleDataModel data, _) =>
                  //               data.high,
                  //           openValueMapper: (CandleDataModel data, _) =>
                  //               data.open,
                  //           closeValueMapper: (CandleDataModel data, _) =>
                  //               data.close,
                  //           bullColor: Colors.greenAccent,
                  //           bearColor: Colors.redAccent,
                  //           enableSolidCandles: true,
                  //           borderWidth: 1,
                  //         ),
                  //       ],
                  //       trackballBehavior: TrackballBehavior(
                  //         enable: true,
                  //         activationMode: ActivationMode.singleTap,
                  //         tooltipSettings: InteractiveTooltip(
                  //           enable: true,
                  //           color: Colors.black87,
                  //           textStyle: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 12,
                  //           ),
                  //         ),
                  //       ),
                  //       zoomPanBehavior: ZoomPanBehavior(
                  //         enablePinching: true,
                  //         enablePanning: true,
                  //         zoomMode: ZoomMode.x,
                  //         maximumZoomLevel: 0.004,
                  //         enableDirectionalZooming: true,
                  //         enableDoubleTapZooming: true,
                  //         enableMouseWheelZooming: true,
                  //         enableSelectionZooming: true,
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
