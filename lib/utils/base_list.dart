import 'package:flutter/material.dart';
import 'package:provider_demo/utils/base_item.dart';
import 'package:provider_demo/utils/unique_object.dart';

class BaseList<T extends BaseItem> with UniqueObject, ChangeNotifier {
  final List<T> _list = [];
  int get count => _list.length;
  List<T> get list => _list;
  add(T item) {
    _list.add(item);
    notifyListeners();
  }

  remove(T item) {
    _list.remove(item);
    notifyListeners();
  }

  clear() {
    _list.clear();
    notifyListeners();
  }

  T findById(int id) => _list.firstWhere((element) => element.id == id);
  int indexOf(T item) => _list.indexOf(item);

  bool contains(T item) => _list.contains(item);

  T at(int i) => _list[i];
}
