import 'package:flutter/material.dart';
import 'package:provider_demo/model/clip.dart';
class ClipView extends StatefulWidget {
  const ClipView({required this.clip ,super.key});
  final Clip clip;
  @override
  State<ClipView> createState() => _ClipViewState();
}

class _ClipViewState extends State<ClipView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.grey[200],
        height: 40,
        child: Text(widget.clip.name),
      ),
    );
  }
}