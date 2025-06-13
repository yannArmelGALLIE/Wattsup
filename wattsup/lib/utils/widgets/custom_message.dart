import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wattsup/utils/theme/colors.dart';

class CustomMessage extends StatelessWidget {
  const CustomMessage({
    super.key, 
    required this.color, 
    required this.title, 
    required this.subtitle
    });

  final Color color;
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 90,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: TColors.textWhite, size: 40),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: TColors.textWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: TColors.textWhite,
                    fontSize: 15,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
