import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/app_model.dart';
import 'package:provider_demo/model/clip.dart';
import 'package:provider_demo/model/track.dart';
import 'package:provider_demo/views/clip_view.dart';

class TrackView extends StatefulWidget {
  const TrackView({required this.track, super.key});
  final Track track;
  @override
  State<TrackView> createState() => _TrackViewState();
}

class _TrackViewState extends State<TrackView> {
  @override
  Widget build(BuildContext context) {
    // AppModel appModel = Provider.of<AppModel>(context);
    AppModel appModel = context.watch<AppModel>();
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black45,
        border: Border.all(
            color: appModel.selectedTrackIndex == widget.track.id
                ? Colors.red
                : Colors.lightBlue),
      ),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: 80,
            height: double.infinity,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Colors.lightBlue))),
            child: Text(
              widget.track.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
              child: Stack(
            children: [
              GestureDetector(
                onPanUpdate: (details) {
                  var clip = widget.track.findClipById(appModel.selectedClipId);
                  var deltaX = details.localPosition.dx - clip.start;
                  if (deltaX > 120) {
                    clip.setLength(deltaX);
                    setState(() {});
                  }
                },
                onPanDown: (details) {
                  Clip clip = Clip();
                  appModel
                    ..setSelectedTrackIndex(widget.track.id)
                    ..setSelectedClipId(clip.id);
                  clip.setStart(details.localPosition.dx);
                  clip.setClipStart(details.localPosition.dx);
                  clip.setName("New Clip");
                  clip.setLength(120);
                  widget.track.insertClip(clip);
                },
                child: Container(
                  color: Colors.grey,
                ),
              ),
              Stack(
                children: appModel
                    .findTrackById(widget.track.id)
                    .clips
                    .list
                    .map((e) => Positioned(
                        left: e.start,
                        top: 4,
                        child: ClipView(
                          clip: e,
                          dragFn: (start) {
                            e.setStart(start);
                            setState(() {});
                          },
                          selected: appModel.selectedClipId == e.id,
                        )))
                    .toList(),
              )
            ],
          ))
        ],
      ),
    );
  }
}
