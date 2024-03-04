import 'package:flutter/material.dart';
import 'package:provider_demo/model/track_controller.dart';
import 'package:provider_demo/utils/base_list.dart';
import 'package:provider_demo/utils/unique_object.dart';
import 'clip.dart';

class Track with ChangeNotifier, UniqueObject {
  String _name = "";
  get name => _name;
  setName(String name) {
    _name = name;
    notifyListeners();
  }

  int _index = 0;
  int get index => _index;
  setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  TrackController _controller = TrackController();
  get controller => _controller;
  setController(TrackController controller) {
    _controller = controller;
    notifyListeners();
  }

  final BaseList<Clip> _clips = BaseList();
  BaseList<Clip> get clips => _clips;

  insertClip(Clip clip) {
    _clips.add(clip);
    notifyListeners();
  }

  insertClipAt(Clip clip, int index) {
    _clips.insert(clip, index);
    notifyListeners();
  }

  insertClipQuietly(Clip clip) {
    _clips.add(clip);
  }

  T findClipById<T>(int id) {
    return _clips.findById(id) as T;
  }

  fromTrack(Track other) {
    _name = other.name;
    _index = other.index;
    _controller = other.controller;
    _clips.clear();
    _clips.addAll(other.clips);
  }

  removeClip(Clip clip) {
    _clips.remove(clip);
    notifyListeners();
  }

  removeClipQuietly(Clip clip) {
    _clips.remove(clip);
  }

  notifyClipChanged(Clip clip) {
    var index = _clips.indexOf(clip);
    removeClip(clip);
    insertClipAt(clip, index);
    notifyListeners();
  }
}
