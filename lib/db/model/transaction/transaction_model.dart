import 'package:hive_flutter/adapters.dart';
import 'package:moneymanager/db/model/catogory/catogory_model.dart';
part 'transaction_model.g.dart';


@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
   String porpose;

  @HiveField(1)
   double amount;

  @HiveField(2)
   DateTime dateTime;

  @HiveField(3)
  CatogoryType catogoryType;

  @HiveField(4)
   CatogoryModel catogoryModel;

  @HiveField(5)
  String? id;

  @HiveField(5)
  DateTime? deleteDate;

  TransactionModel(
      {required this.porpose,
      required this.amount,
      required this.dateTime,
      required this.catogoryType,
      required this.catogoryModel,
      required this.id
      });
}
