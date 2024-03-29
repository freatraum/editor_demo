import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/app_model.dart';
import 'package:provider_demo/model/clip.dart';
import 'package:provider_demo/model/clip_list.dart';
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
    AppModel appModel = context.watch<AppModel>();
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black45,
        border: Border.all(
            color: appModel.selectedTrackId == widget.track.id
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
                  var clip = widget.track
                      .findClipById<SingingClip>(appModel.selectedClipId);
                  // var clip1 =
                  //     clipListModel.findClipById(appModel.selectedClipId);
                  var deltaX = details.localPosition.dx - clip.start;
                  if (deltaX > 120) {
                    clip.setLength(deltaX);
                    appModel.updateClip(clip);
                    // clipListModel.updateClip(clip1);
                    // setState(() {});
                  }
                },
                onPanDown: (details) {
                  SingingClip singingClip = SingingClip();
                  appModel
                    ..setSelectedTrackId(widget.track.id)
                    ..setSelectedClipId(singingClip.id);
                  singingClip.setStart(details.localPosition.dx);
                  singingClip.setClipStart(details.localPosition.dx);
                  singingClip.setName("New Clip");
                  singingClip.setLength(120);
                  widget.track.insertClip(singingClip);
                  // clipListModel.insertClip(singingClip);
                },
                child: Container(
                  color: Colors.grey,
                ),
              ),
              Stack(
                children: widget.track.clips.list
                    .map((e) => Positioned(
                        left: e.start,
                        top: 4,
                        child: ClipView(
                          clip: e,
                          dragFn: (start) {
                            e.setStart(start);
                            // setState(() {});
                            appModel.updateClip(e);
                          },
                          selected: appModel.selectedClipId == e.id,
                        )))
                    .toList(),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
