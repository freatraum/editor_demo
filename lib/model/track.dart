import 'package:flutter/material.dart';
import 'package:provider_demo/model/track_controller.dart';
import 'package:provider_demo/utils/unique_object.dart';
import 'clip.dart';
class Track with ChangeNotifier, UniqueObject {
  String _name = "";
  get name=>_name;
  setName(String name){
    _name = name;
    notifyListeners();
  }

  int _index = 0;
  int get index=>_index;
  setIndex(int index){
    _index=index;
    notifyListeners();
  }

  TrackController _controller = TrackController();
  get controller =>_controller;
  setController(TrackController controller){
    _controller=controller;
    notifyListeners();
  }

  final List<Clip> _clips=[];
  List<Clip> get clips=>_clips;

  insertClip(Clip clip){
    _clips.add(clip);
    notifyListeners();
  }
  insertClipQuietly(Clip clip){
    _clips.add(clip);
  }

  Clip findClipById(int id){
    return _clips.firstWhere((element) => element.id==id);
  }

  removeClip(Clip clip){
    _clips.remove(clip);
    notifyListeners();
  }

  removeClipQuietly(Clip clip){
    _clips.remove(clip);
  }

  update(){
    notifyListeners();
  }

}