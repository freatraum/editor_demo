import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/app_model.dart';
import 'package:provider_demo/model/clip.dart';
import 'package:provider_demo/model/track.dart';
import 'package:provider_demo/views/clip_view.dart';

class TrackView extends StatefulWidget {
  const TrackView({required this.track ,super.key});
  final Track track;
  @override
  State<TrackView> createState() => _TrackViewState();
}

class _TrackViewState extends State<TrackView> {
  @override
  Widget build(BuildContext context) {
  AppModel appModel = Provider.of<AppModel>(context);

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black45,
        border: Border.all(color: Colors.lightBlue)
      ),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: 80,
            height: double.infinity,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: Colors.lightBlue))
            ),
            child: Text(widget.track.name,overflow: TextOverflow.ellipsis,),
          ),
          Expanded(child: GestureDetector(
            onPanDown: (details) {
              
              Clip clip = Clip();
              clip.setStart(details.localPosition.dx);
              clip.setName("New Clip");
              widget.track.insertClip(clip);
              // appModel.tracks.first.insterClip(clip);
            },
            child: Container(
              color: Colors.grey,
              child: Stack(
                children: widget.track.clips.map((e) => Positioned(left: e.start,child: ClipView(clip: e))).toList(),
              ),
            ),
          ))
        ],
      ),
    );
  }
}