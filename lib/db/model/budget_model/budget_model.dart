import 'package:hive_flutter/adapters.dart';
import 'package:moneymanager/db/model/catogory/catogory_model.dart';
 part 'budget_model.g.dart';

@HiveType(typeId: 5)
class BudgetModel{
  @HiveField(0)
   CatogoryModel catogoryModel;
  @HiveField(1)
   double budget;
  @HiveField(2)
   bool selected;

  BudgetModel( {required this.catogoryModel, required this.budget,required this.selected,});

}