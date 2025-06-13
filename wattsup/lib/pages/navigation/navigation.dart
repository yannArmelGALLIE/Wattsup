import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:wattsup/pages/navigation/screens/animated_bar.dart';
import 'package:wattsup/pages/navigation/screens/nav_bar_controller.dart';
import 'package:wattsup/utils/models/nav_item_model.dart';
import 'package:wattsup/utils/theme/colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final controller = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.secondary,
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
          decoration: BoxDecoration(
            color: TColors.secondary.withOpacity(0.8),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: TColors.orange, width: 3)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(bottomNavItems.length, (index) {
              final riveIcon = bottomNavItems[index].rive;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    controller.selectedIndex.value = index;
                  });
                  if (riveIcon.status != null) {
                    riveIcon.status!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      riveIcon.status!.change(false);
                    });
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBar(
                      isActive: controller.selectedIndex.value == index,
                    ),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity: controller.selectedIndex.value == index ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          riveIcon.src,
                          artboard: riveIcon.artboard,
                          onInit: (artboard) {
                            final smc = StateMachineController.fromArtboard(
                              artboard,
                              riveIcon.stateMachineName,
                            );
                            if (smc != null) {
                              artboard.addController(smc);
                              riveIcon.setStatus =
                                  smc.findInput<bool>("active") as SMIBool;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}





