import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/app_model.dart';
import 'package:provider_demo/model/clip.dart';
import 'package:provider_demo/model/note.dart';

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
    return Stack(
      children: [
        Consumer<AppModel>(
          builder: (context, value, child) {
            SingingClip singingClip = value
                .findTrackById(value.selectedTrackIndex)
                .findClipById(value.selectedClipId) as SingingClip;
            return GestureDetector(
              onPanDown: (details) {
                Note note = Note(start: details.localPosition.dx);
                singingClip.insertNote(note);
                setState(() {});
              },
              child: child,
            );
          },
          child: Container(
            height: widget.height - 322 > 0 ? widget.height - 322 : 178,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
            width: widget.width,
          ),
        ),
        Consumer<AppModel>(
          builder: (context, value, child) {
            var clip = value
                .findTrackById(value.selectedTrackIndex)
                .findClipById(value.selectedClipId);
            return SizedBox(
              height: widget.height - 322 > 0 ? widget.height - 322 : 178,
              width: widget.width,
              child: Stack(
                children: clip.type == ClipType.singing
                    ? (clip as SingingClip).notes.map((e) {
                        return Positioned(
                          left: e.start,
                          top: 20,
                          child: Container(
                            height: 20,
                            width: 20,
                            color: Colors.black,
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
    );
  }
}