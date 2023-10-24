import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanager/db/function/catogory/catogory_db.dart';
import 'package:moneymanager/db/function/transaction/transaction_db.dart';
import 'package:moneymanager/db/model/budget_model/budget_model.dart';
import 'package:moneymanager/db/model/catogory/catogory_model.dart';
import 'package:moneymanager/db/model/target/target_model.dart';
import 'package:moneymanager/db/model/transaction/transaction_model.dart';
import 'package:moneymanager/screens/home_screen/add_target.dart';
import 'package:moneymanager/screens/splash_screen.dart';

Future<void> clearAll(BuildContext context) async {
  var catogoryBox = await Hive.openBox<CatogoryModel>('catogory');
  await catogoryBox.clear();
  CatogoryDb().refreshUi();
  var transactionBox =
      await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
  await transactionBox.clear();
TransactionDb().refreshUi();
  var targetBox = await Hive.openBox<TargetModelOfMoney>('Target-Db');
  await targetBox.clear();

  var deletedBox = await Hive.openBox<TransactionModel>(deletedDbName);
  await deletedBox.clear();
  TransactionDb().deleteRefresh();
  final bBox=await Hive.openBox<BudgetModel>('budget');
  await bBox.clear();
await CatogoryDb().budgetRefresh();
  
  targetModelListener.value = TargetModelOfMoney(
      target: 'Add Target', startTime: DateTime.now(), endTime: DateTime.now());

  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx){
    return SplashScreen();
  }), (route) => false);

}
