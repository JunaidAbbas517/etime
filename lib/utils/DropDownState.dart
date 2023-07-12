import 'package:flutter/material.dart';

class DropdownState extends ChangeNotifier {
  String selectedValue = 'All';
  String selectedMonth = DateTime.now().month.toString();
  int selectedYear = DateTime.now().year;

  void updateValue(String newValue) {
    selectedValue = newValue;
    notifyListeners();
  }

  void updateMonth(String newMonth) {
    selectedMonth = newMonth;
    notifyListeners();
  }

  void updateYear(int newYear) {
    selectedYear = newYear;
    notifyListeners();
  }
}
