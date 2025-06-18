import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  bool _hasNewNotification = false;

  bool get hasNewNotification => _hasNewNotification;

  void markAsNew() {
    _hasNewNotification = true;
    notifyListeners();
  }

  void clearNotification() {
    _hasNewNotification = false;
    notifyListeners();
  }
}
