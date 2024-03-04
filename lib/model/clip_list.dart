import 'package:flutter/material.dart';
import 'package:provider_demo/model/clip.dart';

class ClipListModel with ChangeNotifier {
  final List<Clip> _list = [];
  List<Clip> get list => _list;
  insertClip(Clip clip) {
    _list.add(clip);
    notifyListeners();
  }

  updateClipList(List<Clip> list) {
    _list.clear();
    _list.addAll(list);
    notifyListeners();
  }

  updateClip(Clip clip) {
    int index = _list.indexOf(clip);
    _list[index] = clip;
    notifyListeners();
  }

  Clip findClipById(int id) {
    return _list.firstWhere((clip) => clip.id == id);
  }

  reset() {
    _list.clear();
    notifyListeners();
  }
}
