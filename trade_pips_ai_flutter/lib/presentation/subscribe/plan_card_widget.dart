import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/presentation/subscribe/subscribe_controller.dart';

class PlanCard extends GetView<SubscribeController> {
  final String planName;
  final String price;
  final String duration;
  final List<String> thingsToGet;
  final VoidCallback onSubscribe;

  const PlanCard({
    super.key,
    required this.planName,
    required this.price,
    required this.duration,
    required this.onSubscribe,
    required this.thingsToGet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                planName.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Geologica',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Container(
                width: 84,
                height: 31,
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFC0C0C0),
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Select", // change text as needed
                  style: TextStyle(
                    fontFamily: 'Geologica',
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    height: 1.5, // line-height 150%
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// ── PRICE ──────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontFamily: 'Geologica',
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  duration,
                  style: const TextStyle(
                    fontFamily: 'Geologica',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// ── FEATURE ROW ────────────────────────
          ...thingsToGet.map(
            (thing) {
              return Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 18,
                    color: Color(0xFF031A34),
                  ),
                  SizedBox(width: 10),
                  Text(
                    thing,
                    style: TextStyle(
                      fontFamily: 'Geologica',
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 16),

          /// ── CTA BUTTON (CLICKABLE) ─────────────
          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 59,
              child: ElevatedButton(
                onPressed: controller.isLoading.value ? () {} : onSubscribe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC0C0C0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: controller.isLoading.value
                    ? SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          color: Colors.black,
                          strokeCap: StrokeCap.round,
                        ),
                      )
                    : const Text(
                        "Select Plan",
                        style: TextStyle(
                          fontFamily: 'Geologica',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
