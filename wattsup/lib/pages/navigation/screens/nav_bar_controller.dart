import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:wattsup/pages/historical/historical_page.dart';
import 'package:wattsup/pages/main/main_page.dart';
import 'package:wattsup/pages/profile/profile_page.dart';
import 'package:wattsup/pages/settings/settings_page.dart';

class NavBarController extends GetxController {
  final selectedIndex = 0.obs;

  final screens = [
    MainPage(),
    HistoricalPage(),
    SettingsPage(),
    ProfilePage()
  ];
}