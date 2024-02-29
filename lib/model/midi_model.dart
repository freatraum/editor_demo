class MidiModel {
  static String midiToName(int keyNum) {
    Map<int, String> midiValues = {
      0: 'C',
      1: 'C#',
      2: 'D',
      3: 'D#',
      4: 'E',
      5: 'F',
      6: 'F#',
      7: 'G',
      8: 'G#',
      9: 'A',
      10: 'A#',
      11: 'B'
    };

    int octave = keyNum ~/ 12 - 1;
    String name = midiValues[keyNum % 12] ?? '';

    return '$name$octave';
  }

  static List<int> keys() {
    List<int> keys = [];
    for (int i = 40; i <= 102; i++) {
      keys.add(i);
    }
    return keys;
  }
}
