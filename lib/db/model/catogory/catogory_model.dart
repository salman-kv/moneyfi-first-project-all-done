import 'package:hive_flutter/adapters.dart';
part 'catogory_model.g.dart';


@HiveType(typeId: 1)
enum CatogoryType {

  @HiveField(0)
  income,

  @HiveField(1)
  expense,

  @HiveField(2)
  undifined
}


@HiveType(typeId: 0)
class CatogoryModel { 

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  bool isDeleted;

  @HiveField(3)
  CatogoryType type;

  CatogoryModel(
      {required this.id,
      required this.name,
      required this.type,
      required this.isDeleted});
}
