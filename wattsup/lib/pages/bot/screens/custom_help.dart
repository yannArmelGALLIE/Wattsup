
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHelp extends StatelessWidget {
  const CustomHelp({
    super.key,
    required this.message,
    required this.color,
    required this.icon
  });

  final String message;
  final Color color;
  final IconData icon;



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: color),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.poppins(color: color, fontSize: 16),
            ),
          ),
        ],
      ),
    
    );
  }
}

