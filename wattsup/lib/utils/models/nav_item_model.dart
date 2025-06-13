import 'rive_model.dart';

class NavItemModel {
  final String title;
  final RiveModel rive;

  NavItemModel({required this.title, required this.rive});
}

List<NavItemModel> bottomNavItems = [
  NavItemModel(
    title: "Home",
    rive: RiveModel(
      src: "assets/animated_icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_Interactivity"
    ),
  ),
  NavItemModel(
    title: "Timer",
    rive: RiveModel(
      src: "assets/animated_icons.riv",
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity"
    ),
  ),

  NavItemModel(
    title: "Settings",
    rive: RiveModel(
      src: "assets/animated_icons.riv",
      artboard: "SETTINGS",
      stateMachineName: "SETTINGS_Interactivity"
    ),
  ),  NavItemModel(
    title: "User",
    rive: RiveModel(
      src: "assets/animated_icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity"
    ),
  ),
];

// List<NavItemModel> bottomNavItemsl = [
//   NavItemModel(
//     title: "Chat",
//     rive: RiveModel(
//       src: "assets/animated_icons.riv",
//       artboard: "CHAT",
//       stateMachineName: "CHAT_Interactivity"
//     ),
//   ),
//   NavItemModel(
//     title: "Home",
//     rive: RiveModel(
//       src: "assets/animated_icons.riv",
//       artboard: "HOME",
//       stateMachineName: "HOME_Interactivity"
//     ),
//   ),
//   NavItemModel(
//     title: "Search",
//     rive: RiveModel(
//       src: "assets/animated_icons.riv",
//       artboard: "SEARCH",
//       stateMachineName: "SEARCH_Interactivity"
//     ),
//   ),
//   NavItemModel(
//     title: "Timer",
//     rive: RiveModel(
//       src: "assets/animated_icons.riv",
//       artboard: "TIMER",
//       stateMachineName: "TIMER_Interactivity"
//     ),
//   ),
//   NavItemModel(
//     title: "User",
//     rive: RiveModel(
//       src: "assets/animated_icons.riv",
//       artboard: "USER",
//       stateMachineName: "USER_Interactivity"
//     ),
//   ),
//   NavItemModel(
//     title: "Refresh",
//     rive: RiveModel(
//       src: "assets/animated_icons.riv",
//       artboard: "REFRESH/RELOAD",
//       stateMachineName: "REFRESH/RELOAD_Interactivity"
//     ),
//   ),
//   NavItemModel(
//     title: "Like",
//     rive: RiveModel(
//       src: "assets/animated_icons.riv",
//       artboard: "LIKE/STAR",
//       stateMachineName: "LIKE/STAR_Interactivity"
//     ),
//   ),
//   NavItemModel(
//     title: "Bell",
//     rive: RiveModel(
//       src: "assets/animated_icons.riv",
//       artboard: "BELL",
//       stateMachineName: "BELL_Interactivity"
//     ),
//   ),
//   NavItemModel(
//     title: "Settings",
//     rive: RiveModel(
//       src: "assets/animated_icons.riv",
//       artboard: "SETTINGS",
//       stateMachineName: "SETTINGS_Interactivity"
//     ),
//   ),
//   NavItemModel(
//     title: "Audio",
//     rive: RiveModel(
//       src: "assets/animated_icons.riv",
//       artboard: "AUDIO",
//       stateMachineName: "AUDIO_Interactivity"
//     ),
//   ),
// ];