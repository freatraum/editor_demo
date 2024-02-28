import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider_demo/note_audio.dart';

class AudioModel with ChangeNotifier {
  final Map<int, String> _audioSources = {};
  final Map<int, AudioPlayer> _audioPlayers = {};
  // bool _playing = false;

  AudioModel() {
    for (var i = 0; i < notesAudioResource.length; i++) {
      _audioSources[i] = notesAudioResource[i];
    }
  }
  Future<void> play(int index) async {
    if (!_audioSources.containsKey(index)) {
      return;
    }
    if (_audioPlayers.containsKey(index) &&
        _audioPlayers[index]!.state == PlayerState.playing) {
      return;
    }

    final AudioPlayer player = AudioPlayer();
    final AssetSource source = AssetSource(_audioSources[index]!);
    player.play(source);
    player.onPlayerComplete.listen((event) {
      _audioPlayers.remove(index);
      notifyListeners();
    });
    // final AudioSource source = _audioSources[index]!;
    // await player.setAudioSource(source);
    // player.play();
    print(player);
    // player.playbackEventStream.listen((event) {
    //   if (event.processingState == ProcessingState.completed) {
    //     _audioPlayers.remove(index);
    //     notifyListeners();
    //   }
    // });

    notifyListeners();
  }

  Future<void> stop(int index) async {
    if (!_audioPlayers.containsKey(index)) {
      return;
    }
    final AudioPlayer player = _audioPlayers[index]!;
    await player.stop();
    _audioPlayers.remove(index);
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
