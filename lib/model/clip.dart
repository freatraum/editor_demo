import 'package:flutter/material.dart';
import 'package:provider_demo/model/note.dart';
import 'package:provider_demo/utils/unique_object.dart';

enum ClipType {audio,singing,generic}

class Clip extends ChangeNotifier with UniqueObject{
  String _name = "";
  get name =>_name;
  setName(String name){
    _name = name;
    notifyListeners();
  }
  int _start = 0;
  get start=>_start;
  setStart(int start){
    _start = start;
    notifyListeners();
  }

  int _length = 0;
  get length=>_length;
  setLength(int length){
    _length = length;
    notifyListeners();
  }

  int _clipStart = 0;
  get clipStart=>_clipStart;
  setClipStart(int clipStart){
    _clipStart=clipStart;
    notifyListeners();
  }

  int _gain = 0;
  get gain=>_gain;
  setGain(int gain){
    _gain = gain;
    notifyListeners();
  }

  bool _mute = false;
  get mute=>_mute;
  setMute(bool mute){
    _mute=mute;
    notifyListeners();
  }

  
  get type=>ClipType.generic;


}

class AudioClip extends Clip {
  @override
  get type => ClipType.audio;

  String _path = "";
  get path=>_path;
  setPath(String path){
    _path =path;
  }

}

class SingingClip extends Clip {
  final List<Note> _notes = [];
  get notes=>_notes;
  insertNote(Note note){
    _notes.add(note);
    notifyListeners();
  }
  removeNote(Note note){
    _notes.remove(note);
    notifyListeners();
  }
}





