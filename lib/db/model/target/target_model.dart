
import 'package:hive_flutter/adapters.dart';
  part 'target_model.g.dart';

@HiveType(typeId:4)
class TargetModelOfMoney{
  @HiveField(0)
   String target;

   @HiveField(1)
    DateTime startTime;

   @HiveField(2)
    DateTime endTime;

   TargetModelOfMoney({required this.target,required this.startTime,required this.endTime});

}