import 'package:flutter/material.dart';
import 'package:provider_demo/model/midi_model.dart';
import 'package:provider_demo/utils/color.dart';

class NoteStageBgPainter extends CustomPainter {
  final double keyWidth;
  final double keyHeight;
  final List<int> midiKeys = MidiModel.keys();
  NoteStageBgPainter({
    required this.keyHeight,
    required this.keyWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (var i = 0; i < midiKeys.length; i++) {
      int key = midiKeys[i];
      String keyName = MidiModel.midiToName(key);
      bool isBlackKey = keyName.contains("#");
      if (isBlackKey) {
        paint.color = color3A3B3C;
      } else {
        paint.color = colorDADADA;
      }

      canvas.drawRect(
        Rect.fromLTWH(0, i * keyHeight + 1, keyWidth, keyHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
