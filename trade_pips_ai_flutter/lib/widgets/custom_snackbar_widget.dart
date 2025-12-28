import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/controllers/top_snack_bar_controller.dart';

class TopSnackBarWidget extends StatelessWidget {
  const TopSnackBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TopSnackBarController>();

    return Obx(() {
      if (controller.snacks.isEmpty) {
        return const SizedBox.shrink();
      }

      return Stack(
        children: controller.snacks.asMap().entries.map((entry) {
          final index = entry.key;
          final snack = entry.value;

          return KeyedSubtree(
            key: ValueKey(snack.id), // 🔑 prevents animation corruption
            child: _RainSnackItem(
              snack: snack,
              index: index,
            ),
          );
        }).toList(),
      );
    });
  }
}

class _RainSnackItem extends StatefulWidget {
  final TopSnack snack;
  final int index;

  const _RainSnackItem({required this.snack, required this.index});

  @override
  State<_RainSnackItem> createState() => _RainSnackItemState();
}

class _RainSnackItemState extends State<_RainSnackItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late Animation<double> opacity;
  late Animation<double> scale;
  late Animation<double> exitOffset;

  bool isExiting = false;

  double get targetTop => 20.0 + (widget.index * 60);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _buildEnterAnimations();
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), _startExit);
  }

  void _buildEnterAnimations() {
    opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    scale = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    exitOffset = ConstantTween<double>(0).animate(_controller);
  }

  void _startExit() {
    if (!mounted || isExiting) return;

    setState(() {
      isExiting = true;
    });

    _controller.reset();
    _controller.duration = const Duration(milliseconds: 300);

    opacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    scale = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    exitOffset = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward().then((_) {
      final controller = Get.find<TopSnackBarController>();
      if (controller.snacks.contains(widget.snack)) {
        controller.snacks.remove(widget.snack);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        double verticalShift;

        if (isExiting) {
          verticalShift = exitOffset.value;
        } else {
          final double entryOffset = -80 - targetTop;
          final double entryCurve = Curves.easeOutCubic.transform(
            _controller.value,
          );
          verticalShift = entryOffset * (1 - entryCurve);
        }

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutBack,
          left: 16,
          right: 16,
          top: targetTop,

          child: Transform.translate(
            offset: Offset(0, verticalShift),
            child: Opacity(
              opacity: opacity.value,
              child: Transform.scale(
                scale: scale.value,
                alignment: Alignment.center,
                child: _SnackUI(snack: widget.snack),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SnackUI extends StatelessWidget {
  final TopSnack snack;

  const _SnackUI({required this.snack});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 357,
        height: 53,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: snack.backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white.withAlpha(64),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              snack.icon,
              size: 19,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                snack.message,
                style: const TextStyle(
                  fontFamily: 'Geologica',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.75,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
