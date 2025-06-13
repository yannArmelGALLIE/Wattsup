import 'package:flutter/material.dart';
import 'package:wattsup/utils/theme/colors.dart';


class TTabBar extends StatelessWidget  {
  const TTabBar({
    super.key,
    required this.tabs
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: TColors.secondary,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: TColors.secondary,
        labelColor: TColors.textWhite,
        unselectedLabelColor: TColors.orange,
      ),
    );
  }
}