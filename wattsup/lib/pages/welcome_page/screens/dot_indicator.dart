import 'package:flutter/material.dart';
import 'package:wattsup/utils/theme/colors.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: isActive ? TColors.orange : TColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}
