import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/track.dart';

class TrackView extends StatefulWidget {
  const TrackView({required this.track ,super.key});
  final Track track;
  @override
  State<TrackView> createState() => _TrackViewState();
}

class _TrackViewState extends State<TrackView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.black45,
      width: double.infinity,
      child: Text(widget.track.name),
    );
  }
}