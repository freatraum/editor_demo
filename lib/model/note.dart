import 'package:flutter/material.dart';
import 'package:provider_demo/utils/unique_object.dart';

class Note with ChangeNotifier, UniqueObject {
  Note({double? start, double? length, String? lyric}) {
    _start = start ?? 0;
  }

  double _start = 0;
  double get start => _start;
  setStart(double start) {
    _start = start;
    notifyListeners();
  }

  double _length = 480;
  get length => _length;
  setLength(double length) {
    _length = length;
  }

  String _lyric = "喵";
  get lyric => _lyric;
  setLyric(String lyric) {
    _lyric = lyric;
  }
}
