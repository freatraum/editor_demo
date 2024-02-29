import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider_demo/model/note.dart';

class TimelineBarModel with ChangeNotifier {
  int _currentPos = 0;
  int get currentPos => _currentPos;
  Timer? _timer;
  set currentPos(int value) {
    _currentPos = value;
    notifyListeners();
  }

  TimelineBarModel(this._playNote);
  final Future<void> Function(int index) _playNote;
  List<Map<double, int>> _playList = [];
  bool _playing = false;
  bool get playing => _playing;

  play(List<Note> notes) {
    for (var note in notes) {
      _playList.add({note.start: note.noteKey});
    }
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
      _currentPos += 2;
      for (var note in _playList) {
        if (_currentPos - 3 >= note.keys.first) {
          _playNote(note.values.first);
          _playList.remove(note);
        }
      }
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
