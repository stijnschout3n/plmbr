import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:plmbr/services/services.dart';

class AppState extends ChangeNotifier {
  final Map<String, dynamic> _settings = {};
  UnmodifiableMapView<String, dynamic> get settings => UnmodifiableMapView(_settings);

  void login() {
    _settings['username'] = 'stijn';
    notifyListeners();
  }
}
