import 'package:flutter/material.dart';
import 'package:provider_demo/model/note.dart';
import 'package:provider_demo/utils/base_item.dart';

enum ClipType { audio, singing, generic }

class Clip with ChangeNotifier, BaseItem {
  String _name = "";
  get name => _name;
  setName(String name) {
    _name = name;
    notifyListeners();
  }

  double _start = 0;
  get start => _start;
  setStart(double start) {
    _start = start;
    notifyListeners();
  }

  double _length = 0;
  get length => _length;
  setLength(double length) {
    _length = length;
    notifyListeners();
  }

  double _clipStart = 0;
  get clipStart => _clipStart;
  setClipStart(double clipStart) {
    _clipStart = clipStart;
    notifyListeners();
  }

  int _gain = 0;
  get gain => _gain;
  setGain(int gain) {
    _gain = gain;
    notifyListeners();
  }

  bool _mute = false;
  get mute => _mute;
  setMute(bool mute) {
    _mute = mute;
    notifyListeners();
  }

  ClipType get type => ClipType.generic;
}

class AudioClip extends Clip {
  @override
  ClipType get type => ClipType.audio;

  String _path = "";
  get path => _path;
  setPath(String path) {
    _path = path;
  }
}

class SingingClip extends Clip {
  final List<Note> _notes = [];

  @override
  ClipType get type => ClipType.singing;
  List<Note> get notes => _notes;
  insertNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  removeNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }
}
