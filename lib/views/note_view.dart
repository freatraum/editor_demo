import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/app_model.dart';
import 'package:provider_demo/model/drag_action_model.dart';
import 'package:provider_demo/model/note.dart';

class NoteView extends StatefulWidget {
  const NoteView({required this.note, super.key});

  final Note note;
  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.note.start,
      top: widget.note.y,
      child: Consumer2<AppModel, DragActionModel>(
        builder: (context, appModel, dragActionModel, child) {
          return GestureDetector(
            onHorizontalDragEnd: (details) {
              widget.note.noteStart = widget.note.start;
            },
            onHorizontalDragUpdate: (details) {
              var delta = details.localPosition.dx - dragActionModel.dragStartX;
              widget.note.setStart(widget.note.noteStart + delta);
              setState(() {});
            },
            onHorizontalDragStart: (details) {
              dragActionModel.setDragStart(details.localPosition.dx);
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
            child: child,
          );
        },
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
