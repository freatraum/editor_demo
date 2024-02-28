final List<String> notesAudioResource = [
  "asset/note100.wav",
  "asset/note101.wav",
  "asset/note102.wav",
  "asset/note40.wav",
  "asset/note41.wav",
  "asset/note42.wav",
  "asset/note43.wav",
  "asset/note44.wav",
  "asset/note45.wav",
  "asset/note46.wav",
  "asset/note47.wav",
  "asset/note48.wav",
  "asset/note49.wav",
  "asset/note50.wav",
  "asset/note51.wav",
  "asset/note52.wav",
  "asset/note53.wav",
  "asset/note54.wav",
  "asset/note55.wav",
  "asset/note56.wav",
  "asset/note57.wav",
  "asset/note58.wav",
  "asset/note59.wav",
  "asset/note60.wav",
  "asset/note61.wav",
  "asset/note62.wav",
  "asset/note63.wav",
  "asset/note64.wav",
  "asset/note65.wav",
  "asset/note66.wav",
  "asset/note67.wav",
  "asset/note68.wav",
  "asset/note69.wav",
  "asset/note70.wav",
  "asset/note71.wav",
  "asset/note72.wav",
  "asset/note73.wav",
  "asset/note74.wav",
  "asset/note75.wav",
  "asset/note76.wav",
  "asset/note77.wav",
  "asset/note78.wav",
  "asset/note79.wav",
  "asset/note80.wav",
  "asset/note81.wav",
  "asset/note82.wav",
  "asset/note83.wav",
  "asset/note84.wav",
  "asset/note85.wav",
  "asset/note86.wav",
  "asset/note87.wav",
  "asset/note88.wav",
  "asset/note89.wav",
  "asset/note90.wav",
  "asset/note91.wav",
  "asset/note92.wav",
  "asset/note93.wav",
  "asset/note94.wav",
  "asset/note95.wav",
  "asset/note96.wav",
  "asset/note97.wav",
  "asset/note98.wav",
  "asset/note99.wav",
];

class Plist<T extends String> {
  final List<T> _list = [];
  Plist(List<T> list) {
    _list.addAll(list);
  }
  T operator [](int index) {
    return _list.firstWhere((element) {
      var temp = element.split(".").first.split("note").last;
      if (temp == index.toString()) {
        return true;
      } else {
        return false;
      }
    });
  }

  operator []=(int index, T value) {
    _list[index] = value;
  }

  push(T value) {
    _list.add(value);
  }

  clear() {
    _list.clear();
  }

  int get length => _list.length;
}

Plist<String> plist = Plist([
  "asset/note100.wav",
  "asset/note101.wav",
  "asset/note102.wav",
  "asset/note40.wav",
  "asset/note41.wav",
  "asset/note42.wav",
  "asset/note43.wav",
  "asset/note44.wav",
  "asset/note45.wav",
  "asset/note46.wav",
  "asset/note47.wav",
  "asset/note48.wav",
  "asset/note49.wav",
  "asset/note50.wav",
  "asset/note51.wav",
  "asset/note52.wav",
  "asset/note53.wav",
  "asset/note54.wav",
  "asset/note55.wav",
  "asset/note56.wav",
  "asset/note57.wav",
  "asset/note58.wav",
  "asset/note59.wav",
  "asset/note60.wav",
  "asset/note61.wav",
  "asset/note62.wav",
  "asset/note63.wav",
  "asset/note64.wav",
  "asset/note65.wav",
  "asset/note66.wav",
  "asset/note67.wav",
  "asset/note68.wav",
  "asset/note69.wav",
  "asset/note70.wav",
  "asset/note71.wav",
  "asset/note72.wav",
  "asset/note73.wav",
  "asset/note74.wav",
  "asset/note75.wav",
  "asset/note76.wav",
  "asset/note77.wav",
  "asset/note78.wav",
  "asset/note79.wav",
  "asset/note80.wav",
  "asset/note81.wav",
  "asset/note82.wav",
  "asset/note83.wav",
  "asset/note84.wav",
  "asset/note85.wav",
  "asset/note86.wav",
  "asset/note87.wav",
  "asset/note88.wav",
  "asset/note89.wav",
  "asset/note90.wav",
  "asset/note91.wav",
  "asset/note92.wav",
  "asset/note93.wav",
  "asset/note94.wav",
  "asset/note95.wav",
  "asset/note96.wav",
  "asset/note97.wav",
  "asset/note98.wav",
  "asset/note99.wav",
]);
