class IdGenerator {
  static IdGenerator? _instance;
  int _id = -1;
  get id{
    _id++;
    return _id;
  }

  static IdGenerator instance(){
    return IdGenerator._instance ??= IdGenerator();
  }

}