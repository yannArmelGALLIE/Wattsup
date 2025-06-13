import 'package:flutter/material.dart';
import 'package:wattsup/utils/theme/colors.dart';

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
        color: TColors.orange,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}