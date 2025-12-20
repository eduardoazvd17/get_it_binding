import 'package:flutter/material.dart';

/// Example controller for the Home page.
///
/// This controller manages the counter state and notifies listeners
/// when the counter changes.
class HomeController extends ChangeNotifier {
  int _counter = 0;

  /// Current counter value.
  int get counter => _counter;

  /// Increments the counter and notifies listeners.
  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
}
