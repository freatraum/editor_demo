import 'package:flutter/material.dart';
import 'package:provider_demo/model/track.dart';

class AppModel with ChangeNotifier {
  AppModel() {
    newProject();
  }
  String _projectName = 'New Project';
  get projectName => _projectName;
  setProjectName(String name) {
    _projectName = name;
    notifyListeners();
  }

  int _selectedTrackIndex = -1;
  get selectedTrackIndex => _selectedTrackIndex;
  setSelectedTrackIndex(int index) {
    _selectedTrackIndex = index;
    notifyListeners();
  }

  int _tempo = 120;
  get tempo => _tempo;
  setTempo(int tempo) {
    _tempo = tempo;
    notifyListeners();
  }

  List<Track> _tracks = [];
  List<Track> get tracks => _tracks;

  int _selectedClipId = -1;
  get selectedClipId => _selectedClipId;
  setSelectedClipId(int id) {
    _selectedClipId = id;
    notifyListeners();
  }

  insertTrack(Track track, int index) {
    _tracks.insert(index, track);
    notifyListeners();
  }

  addTrack(Track track) {
    track.setIndex(_tracks.length);
    _tracks.add(track);
    notifyListeners();
  }

  Track findTrackById(int id) {
    return _tracks.firstWhere((element) => element.id == id);
  }

  removeTrack(Track track) {
    _tracks.remove(track);
    notifyListeners();
  }

  removeTrackAt(int index) {
    _tracks.removeAt(index);
    notifyListeners();
  }

  clearTracks() {
    while (_tracks.isNotEmpty) {
      removeTrackAt(0);
    }
    notifyListeners();
  }

  newProject() {
    reset();
    setProjectName("New Project");
    Track newTrack = Track();
    newTrack.setName("New Track");
    addTrack(newTrack);
  }

  reset() {
    _tempo = 120;
    _tracks = [];
    _selectedTrackIndex = -1;
    _selectedClipId = -1;
    notifyListeners();
  }
}
