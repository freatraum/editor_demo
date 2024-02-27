import 'package:flutter/material.dart';
import 'package:provider_demo/model/clip.dart';
class ClipView extends StatelessWidget {
  const ClipView({required this.clip,super.key});
  final Clip clip;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        print(details);
      },
      child: Container(
        
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(Radius.circular(4))
        ),
        height: 40,
        width: clip.length,
        child: Text(clip.name),
      ),
    );
  }
}