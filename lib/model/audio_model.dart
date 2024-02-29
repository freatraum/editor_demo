import 'package:flutter/material.dart';
import 'package:provider_demo/note_audio.dart';
import 'package:kplayer/kplayer.dart';

class AudioModel with ChangeNotifier {
  final Map<int, String> _audioSources = {};
  final Map<int, PlayerController> _audioPlayers = {};

  AudioModel() {
    for (var i = 0; i < notesAudioResource.length; i++) {
      _audioSources[i + 40] = notesAudioResource[i];
    }
  }
  Future<void> play(int index) async {
    if (!_audioSources.containsKey(index)) {
      return;
    }
    if (_audioPlayers.containsKey(index) &&
        _audioPlayers[index]!.status == PlayerStatus.playing) {
      return;
    }
    final PlayerController player = Player.asset(plist[index]);
    player.play();
    player.streams.status.listen((event) {
      if (event == PlayerStatus.ended) {
        _audioPlayers.remove(index);
        notifyListeners();
      }
    });
    notifyListeners();
  }

  Future<void> stop(int index) async {
    if (!_audioPlayers.containsKey(index)) {
      return;
    }
    final PlayerController player = _audioPlayers[index]!;
    await player.stop();
    _audioPlayers.remove(index);
    notifyListeners();
  }

  Future<void> stopAll() async {
    for (final PlayerController player in _audioPlayers.values) {
      await player.stop();
    }
    _audioPlayers.clear();
    notifyListeners();
  }

  void disposed() {
    for (final PlayerController player in _audioPlayers.values) {
      player.dispose();
    }
    _audioPlayers.clear();
  }
}
