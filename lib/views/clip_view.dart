import 'package:flutter/material.dart';
import 'package:provider_demo/model/clip.dart';

class ClipView extends StatelessWidget {
  const ClipView({required this.clip, super.key});
  final Clip clip;
  @override
  Widget build(BuildContext context) {
    double dragStart = 0.0;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        var delta = details.localPosition.dx - dragStart;
        clip.setStart(clip.clipStart + delta);
      },
      onHorizontalDragStart: (details) {
        dragStart = details.localPosition.dx;
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        height: 40,
        width: clip.length,
        child: Text(
          "${clip.name}---${clip.length}",
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
