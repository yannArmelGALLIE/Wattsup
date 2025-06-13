import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wattsup/pages/profile/profile_page.dart';
import 'package:wattsup/pages/settings/screens/section_heading.dart';
import 'package:wattsup/pages/settings/screens/settings_menu_tile.dart';
import 'package:wattsup/utils/theme/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 40,),
                  const TSectionHeading(
                    title: "Paramètres du compte",
                    showActionButton: false,
                  ),
                  const SizedBox(height: 20),
                  TSettingsMenuTile(
                    icon: Icons.person, 
                    title: "Profil",
                    onTap: () {
                      Get.to(() => ProfilePage());
                    },
                    ),
                  TSettingsMenuTile(
                    icon: Icons.notifications,
                    title: "Notifications",
                  ),
                  TSettingsMenuTile(
                    icon: Icons.privacy_tip,
                    title: "Confidentialité du compte",
                  ),
                  SizedBox(height: 20),
                  TSectionHeading(
                    title: "Paramètre de l'application",
                    showActionButton: false,
                  ),
                  SizedBox(height: 20),
                  TSettingsMenuTile(
                    icon: Icons.volume_down,
                    title: "Son et vibration",
                  ),
                  TSettingsMenuTile(icon: Icons.storage, title: "Stockage"),
                  TSettingsMenuTile(
                    icon: Icons.color_lens,
                    title: "Orange-Noir/Blanc Noir",
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                      activeColor: TColors.orange,
                    ),
                  ),
                  const SizedBox(height: 30),

                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Se deconnecter",
                      style: GoogleFonts.poppins(
                        color: TColors.orange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
