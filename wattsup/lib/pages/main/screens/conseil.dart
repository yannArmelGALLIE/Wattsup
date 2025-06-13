import 'package:flutter/widgets.dart';

class Conseil {
  const Conseil({
    required this.message,
    required this.color,
    required this.icon
  });

  final String message;
  final Color color;
  final IconData icon;
}