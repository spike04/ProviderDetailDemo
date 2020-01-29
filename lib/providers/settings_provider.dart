import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  String _units;
  List<String> _waxLines;

  SettingsProvider() {
    _units = 'Imperial';
    _waxLines = ['Swix', 'Toko'];
    loadPreferences();
  }

  // Getters
  String get units => _units;
  List<String> get waxLines => _waxLines;

  // Setters
  setUnits(String units) {
    _units = units;
    notifyListeners();
    savePreferences();
  }

  _setWaxLines(List<String> wasLines) {
    _waxLines = wasLines;
    notifyListeners();
  }

  addWaxLine(String waxLine) {
    if (!_waxLines.contains(waxLine)) {
      _waxLines.add(waxLine);
      notifyListeners();
      savePreferences();
    }
  }

  removeWaxLine(String waxLine) {
    if (_waxLines.contains(waxLine)) {
      _waxLines.remove(waxLine);
      notifyListeners();
      savePreferences();
    }
  }

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('units', _units);
    prefs.setStringList('waxLines', _waxLines);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String units = prefs.getString('units');
    List<String> waxLines = prefs.getStringList('waxLines');

    if (units != null) setUnits(units);
    if (waxLines != null) _setWaxLines(waxLines);
  }
}
