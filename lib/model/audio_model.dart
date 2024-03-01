import 'package:flutter/material.dart';
import 'package:provider_demo/note_audio.dart';
// import 'package:kplayer/kplayer.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioModel with ChangeNotifier {
  final Map<int, String> _audioSources = {};
  // final Map<int, PlayerController> _audioPlayers = {};
  final Map<int, AudioPlayer> _audioPlayers = {};
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
        _audioPlayers[index]!.state == PlayerState.playing) {
      _audioPlayers[index]!.seek(const Duration(seconds: 0));
      return;
    }
    final AudioPlayer player = AudioPlayer();

    player.play(DeviceFileSource(plist[index]));

    player.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        _audioPlayers.removeWhere((key, value) => key == index);
        notifyListeners();
      }
    });
    _audioPlayers[index] = player;

    notifyListeners();
  }

  Future<void> stop(int index) async {
    if (!_audioPlayers.containsKey(index)) {
      return;
    }
    final AudioPlayer player = _audioPlayers[index]!;
    await player.stop();
    _audioPlayers.removeWhere((key, value) => key == index);
    notifyListeners();
  }

  Future<void> stopAll() async {
    for (final AudioPlayer player in _audioPlayers.values) {
      await player.stop();
    }
    _audioPlayers.clear();
    notifyListeners();
  }

  void disposed() {
    for (final AudioPlayer player in _audioPlayers.values) {
      player.dispose();
    }
    _audioPlayers.clear();
  }
}
