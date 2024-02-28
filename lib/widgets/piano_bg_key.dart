import 'package:flutter/material.dart';

class PianoBgKey extends StatelessWidget {
  const PianoBgKey({super.key});

  @override
  Widget build(BuildContext context) {
    generateKeys() {
      List<Widget> keys = [];
      for (int i = 40; i <= 102; i++) {
        keys.add(PianoKey(
          noteKey: i,
        ));
      }
      return keys;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: generateKeys(),
      ),
    );
  }
}

class PianoKey extends StatelessWidget {
  const PianoKey({required this.noteKey, super.key});
  final int noteKey;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 25,
        width: 40,
        decoration: BoxDecoration(border: Border.all(color: Colors.pink)),
      ),
    );
  }
}
