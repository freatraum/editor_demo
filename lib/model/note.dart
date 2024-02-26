import 'package:flutter/material.dart';
import 'package:provider_demo/utils/unique_object.dart';

class Note extends ChangeNotifier with UniqueObject {
  Note({int? start,int?length,String?lyric}){
    _start = start??0;

  }

  int _start = 0;
  get start=>_start;
  setStart(int start){
    _start = start;
    notifyListeners();
  }

  int _length = 480;
  get length=>_length;
  setLength(int length){
    _length =length;
  }

  String _lyric = "喵";
  get lyric=>_lyric;
  setLyric(String lyric){
    _lyric=lyric;
  }
}