import 'package:flutter/material.dart';
import 'package:wattsup/models/mesure.dart';

class MesureProvider extends ChangeNotifier {
  Mesure? _mesure;

  Mesure? get mesure => _mesure;

  void setMesure(Mesure mesure) {
    _mesure = mesure;
    notifyListeners(); // notifie les widgets d’un changement
  }

  void clearMesure() {
    _mesure = null;
    notifyListeners();
  }
}