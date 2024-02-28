import 'package:dart_melty_soundfont/dart_melty_soundfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_pcm_sound/flutter_pcm_sound.dart';
import 'package:provider_demo/res.dart';

class AudioModel with ChangeNotifier {
  final int sampleRate = 44100;
  bool _isPlaying = false;
  bool _pcmSoundLoaded = false;
  bool _soundFontLoaded = false;
  int _remainingFrames = 0;
  int _fedCount = 0;
  int _preNote = 0;

  bool get isPlaying => _isPlaying;
  bool get pcmSoundLoaded => _pcmSoundLoaded;
  bool get soundFontLoaded => _soundFontLoaded;
  int get remainingFrames => _remainingFrames;
  Synthesizer? _synthesizer;
  AudioModel() {
    loadSoundFont().then((_) {
      _soundFontLoaded = true;
      notifyListeners();
    });

    loadPcmSound().then((_) {
      _pcmSoundLoaded = true;
      notifyListeners();
    });
  }

  Future<void> loadPcmSound() async {
    FlutterPcmSound.setFeedCallback(onFeed);
    await FlutterPcmSound.setLogLevel(LogLevel.standard);
    await FlutterPcmSound.setFeedThreshold(8000);
    await FlutterPcmSound.setup(sampleRate: sampleRate, channelCount: 1);
  }

  Future<void> loadSoundFont() async {
    ByteData bytes = await rootBundle.load(Res.Yamaha_C3_Grand_Piano);
    _synthesizer = Synthesizer.loadByteData(bytes, SynthesizerSettings());

    List<Preset> p = _synthesizer!.soundFont.presets;
    for (int i = 0; i < p.length; i++) {
      String instrumentName =
          p[i].regions.isNotEmpty ? p[i].regions[0].instrument.name : "N/A";
      print('[preset $i] name: ${p[i].name} instrument: $instrumentName');
    }
    notifyListeners();
    return Future<void>.value(null);
  }

  onFeed(int remainingFrames) async {
    _remainingFrames = remainingFrames;
    List<int> notes = [60, 62, 64, 65, 67, 69, 71, 72];
    int step = (_fedCount ~/ 16) % notes.length;
    int curNote = notes[step];
    if (curNote != _preNote) {
      _synthesizer!.noteOff(channel: 0, key: _preNote);
      _synthesizer!.noteOn(channel: 0, key: curNote, velocity: 120);
    }
    ArrayInt16 buf16 = ArrayInt16.zeros(numShorts: 1000);
    _synthesizer!.renderMonoInt16(buf16);
    await FlutterPcmSound.feed(PcmArrayInt16(bytes: buf16.bytes));
    _fedCount++;
    _preNote = curNote;
    notifyListeners();
  }

  Future<void> play() async {
    await FlutterPcmSound.play();
    _isPlaying = true;
    _synthesizer!.noteOffAll();
    _synthesizer!.selectPreset(channel: 0, preset: 0);
    notifyListeners();
  }

  Future<void> pause() async {
    await FlutterPcmSound.pause();
    _isPlaying = false;
    notifyListeners();
  }

  close() {
    FlutterPcmSound.release();
    notifyListeners();
  }
}
