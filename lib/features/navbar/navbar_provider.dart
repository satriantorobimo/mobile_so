import 'package:flutter/material.dart';

class NavbarProvider with ChangeNotifier {
  int _page = 0;
  int _navbarNumber = 0;

  int get page => _page;
  int get navbarNumber => _navbarNumber;

  void setPage(int value) {
    _page = value;
    notifyListeners();
  }

  void setTab(int value) {
    _navbarNumber = value;
    notifyListeners();
  }
}
