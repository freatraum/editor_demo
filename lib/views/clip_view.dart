import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/app_model.dart';
import 'package:provider_demo/model/clip.dart';

class ClipView extends StatefulWidget {
  const ClipView(
      {required this.clip,
      required this.dragFn,
      required this.selected,
      super.key});
  final Clip clip;
  final Function(double start) dragFn;
  final bool selected;
  @override
  State<ClipView> createState() => _ClipViewState();
}

class _ClipViewState extends State<ClipView> {
  double dragStart = 0.0;
  @override
  Widget build(BuildContext context) {
    // ClipModel clipModel = Provider.of<ClipModel>(context);

    AppModel appModel = Provider.of(context);
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        widget.clip.setClipStart(widget.clip.start);
      },
      onHorizontalDragUpdate: (details) {
        var delta = details.localPosition.dx - dragStart;
        // widget.clip.setStart(widget.clip.clipStart + delta);
        widget.dragFn(widget.clip.clipStart + delta);
      },
      onHorizontalDragStart: (details) {
        setState(() {
          dragStart = details.localPosition.dx;
        });
      },
      onPanDown: (details) {
        appModel.setSelectedClipId(widget.clip.id);
        for (var element in appModel.tracks) {
          if (element.clips.contains(widget.clip)) {
            appModel.setSelectedTrackIndex(element.id);
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            border: Border.all(
                color:
                    widget.selected ? Colors.pink : const Color(0xFF000000))),
        height: 40,
        width: widget.clip.length,
        child: Text(
          "${widget.clip.name}---${widget.clip.length}",
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
