import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/audio_model.dart';
import 'package:provider_demo/model/midi_model.dart';

class PianoBgKey extends StatelessWidget {
  const PianoBgKey({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: MidiModel.keys().map((e) => PianoKey(noteKey: e)).toList(),
    );
  }
}

class PianoKey extends StatefulWidget {
  const PianoKey({required this.noteKey, super.key});
  final int noteKey;
  @override
  State<PianoKey> createState() => _PianoKeyState();
}

class _PianoKeyState extends State<PianoKey> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    AudioModel audioModel = Provider.of(context);

    return InkWell(
      onTap: () {
        audioModel.play(widget.noteKey);
      },
      onHover: (value) {
        setState(() {
          hover = value;
        });
      },
      child: Container(
        height: 25,
        width: 40,
        decoration: BoxDecoration(
            border: const Border(
                top: BorderSide(color: Colors.black),
                right: BorderSide(color: Colors.black)),
            color: hover
                ? Colors.grey
                : MidiModel.midiToName(widget.noteKey).contains("#")
                    ? Colors.black54
                    : Colors.white54),
        child: Center(child: Text(MidiModel.midiToName(widget.noteKey))),
      ),
    );
  }
}
