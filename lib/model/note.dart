import 'package:flutter/material.dart';
import 'package:provider_demo/utils/unique_object.dart';

class Note with ChangeNotifier, UniqueObject {
  Note({
    required int noteKey,
    double? start,
    double? length,
    String? lyric,
    double? y,
  }) {
    _start = start ?? 0;
    _noteStart = start ?? 0;
    _length = length ?? 50;
    _lyric = lyric ?? '喵';
    _y = y ?? 0;
    _noteKey = noteKey;
  }
  int _noteKey = 60;
  int get noteKey => _noteKey;
  set noteKey(int noteKey) {
    _noteKey = noteKey;
    notifyListeners();
  }

  double _noteStart = 0;
  double get noteStart => _noteStart;
  set noteStart(double value) {
    _noteStart = value;
    notifyListeners();
  }

  double _start = 0;
  double get start => _start;
  setStart(double start) {
    _start = start;
    notifyListeners();
  }

  double _y = 0;
  double get y => _y;
  setY(double y) {
    _y = y;
    notifyListeners();
  }

  double _length = 480;
  get length => _length;
  setLength(double length) {
    _length = length;
    notifyListeners();
  }

  String _lyric = "喵";
  get lyric => _lyric;
  setLyric(String lyric) {
    _lyric = lyric;
    notifyListeners();
  }
}
