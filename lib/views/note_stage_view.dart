import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/app_model.dart';
import 'package:provider_demo/model/clip.dart';
import 'package:provider_demo/model/midi_model.dart';
import 'package:provider_demo/model/note.dart';
import 'package:provider_demo/utils/color.dart';
import 'package:provider_demo/widgets/note_stage_bg_widget.dart';
import 'package:provider_demo/widgets/piano_bg_key.dart';

class NoteStageView extends StatefulWidget {
  const NoteStageView({required this.height, required this.width, super.key});
  final double height;
  final double width;
  @override
  State<NoteStageView> createState() => _NoteStageViewState();
}

class _NoteStageViewState extends State<NoteStageView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Row(
        children: [
          Container(
            width: 40,
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(color: Colors.grey),
            )),
            child: const PianoBgKey(),
          ),
          Expanded(
            child: Stack(
              children: [
                Consumer<AppModel>(
                  builder: (context, value, child) {
                    SingingClip singingClip = value
                        .findTrackById(value.selectedTrackIndex)
                        .findClipById(value.selectedClipId) as SingingClip;
                    return GestureDetector(
                      onPanDown: (details) {
                        Note note = Note(
                            start: details.localPosition.dx,
                            y: details.localPosition.dy);
                        singingClip.insertNote(note);
                        setState(() {});
                      },
                      child: child,
                    );
                  },
                  child: SizedBox(
                    height: MidiModel.keys().length * 25,
                    width: widget.width - 40,
                    child: CustomPaint(
                      painter: NoteStageBgPainter(
                          keyHeight: 25, keyWidth: widget.width - 40),
                      size: Size(widget.width, MidiModel.keys().length * 25),
                    ),
                  ),
                ),
                Consumer<AppModel>(
                  builder: (context, value, child) {
                    var clip = value
                        .findTrackById(value.selectedTrackIndex)
                        .findClipById(value.selectedClipId);
                    return SizedBox(
                      height: MidiModel.keys().length * 25,
                      width: widget.width - 40,
                      child: Stack(
                        children: clip.type == ClipType.singing
                            ? (clip as SingingClip).notes.map((e) {
                                return Positioned(
                                  left: e.start,
                                  top: e.y,
                                  child: Container(
                                    height: 20,
                                    width: e.length,
                                    color: Colors.lightBlue,
                                    child: Text(e.lyric),
                                  ),
                                );
                              }).toList()
                            : [],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
