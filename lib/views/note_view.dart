import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/app_model.dart';
import 'package:provider_demo/model/note.dart';

class NoteView extends StatefulWidget {
  const NoteView({required this.note, super.key});

  final Note note;
  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  double dragStartX = 0.0;

  @override
  Widget build(BuildContext context) {
    AppModel appModel = Provider.of(context);
    return Positioned(
      left: widget.note.start,
      top: widget.note.y,
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          widget.note.noteStart = widget.note.start;
        },
        onHorizontalDragUpdate: (details) {
          var delta = details.localPosition.dx - dragStartX;
          widget.note.setStart(widget.note.noteStart + delta);
          setState(() {});
        },
        onHorizontalDragStart: (details) {
          setState(() {
            dragStartX = details.localPosition.dx;
          });
        },
        onVerticalDragEnd: (details) {
          widget.note.noteKey = 102 - (widget.note.y / 25).floor();
        },
        onVerticalDragUpdate: (details) {
          widget.note.setY(((details.globalPosition.dy +
                              appModel.noteStageScrollOffset -
                              350) /
                          25)
                      .floor() *
                  25 +
              4);
          setState(() {});
        },
        onVerticalDragStart: (details) {},
        child: Container(
          height: 20,
          width: widget.note.length,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 226, 94, 138),
            ),
            color: Colors.lightBlue,
          ),
        ),
      ),
    );
  }
}
