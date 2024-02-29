import 'dart:async';

import 'package:flutter/material.dart';

class TimelineBarModel with ChangeNotifier {
  int _currentPos = 0;
  int get currentPos => _currentPos;
  Timer? _timer;
  set currentPos(int value) {
    _currentPos = value;
    notifyListeners();
  }

  bool _playing = false;
  bool get playing => _playing;

  play() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
      _currentPos += 2;
      notifyListeners();
    });
    _playing = true;
    notifyListeners();
  }

  stop() {
    _timer?.cancel();
    _currentPos = 0;
    _playing = false;
    notifyListeners();
  }

  pause() {
    _timer?.cancel();
    _playing = false;
    notifyListeners();
  }
}
