import 'package:flutter/material.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';

class NoItemsWidget extends StatelessWidget {
  const NoItemsWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/noitems.png',
            scale: 2,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
