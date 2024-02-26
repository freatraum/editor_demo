import 'package:flutter/material.dart';
import 'package:provider_demo/model/track_controller.dart';
import 'package:provider_demo/utils/unique_object.dart';

class Track extends ChangeNotifier with UniqueObject {
  String _name = "";
  get name=>_name;
  setName(String name){
    _name = name;
    notifyListeners();
  }

  TrackController _controller = TrackController();
  get controller =>_controller;
  setController(TrackController controller){
    _controller=controller;
    notifyListeners();
  }

  final List<Clip> _clips=[];
  get clips=>_clips;

  insterClip(Clip clip){
    _clips.add(clip);
    notifyListeners();
  }
  insertClipQuietly(Clip clip){
    _clips.add(clip);
  }

  removeClip(Clip clip){
    _clips.remove(clip);
    notifyListeners();
  }

  removeClipQuietly(Clip clip){
    _clips.remove(clip);
  }

  

}