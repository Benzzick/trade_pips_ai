import 'package:flutter/material.dart';

class CustomToggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomToggle> createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: Container(
        width: 58,
        height: 27,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: widget.value
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            width: 25,
            height: 19,
            decoration: BoxDecoration(
              color: widget.value
                  ? const Color(0xFF228AFF)
                  : const Color.fromRGBO(34, 138, 255, 0.45),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
