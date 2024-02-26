import 'package:provider_demo/utils/id_generator.dart';

mixin class UniqueObject {
  final int _id=IdGenerator.instance().id;
  int get id=>_id;
  // UniqueObject(){
  //   _id=IdGenerator.instance().id;
  // }
}