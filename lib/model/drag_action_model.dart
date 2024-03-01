import 'package:flutter/material.dart';

class DragActionModel with ChangeNotifier {
  double _dragStartX = 0;
  double get dragStartX => _dragStartX;
  setDragStart(double value) {
    _dragStartX = value;
    notifyListeners();
  }
}
