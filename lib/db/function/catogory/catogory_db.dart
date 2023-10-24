import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moneymanager/db/function/transaction/transaction_db.dart';
import 'package:moneymanager/db/model/budget_model/budget_model.dart';
import 'package:moneymanager/db/model/catogory/catogory_model.dart';
import 'package:moneymanager/db/model/transaction/transaction_model.dart';

abstract class CatogoryDbFunction {
  Future<void> insertCatogory(CatogoryModel value);
  Future<List<CatogoryModel>> getCatogory();
  // Future<void> delteCatogory(String id);
  // Future<void> editCatogory(CatogoryModel val);
}

class CatogoryDb implements CatogoryDbFunction {
  CatogoryDb._internal();
  static CatogoryDb catogoryDbInternal = CatogoryDb._internal();
  factory CatogoryDb() {
    return catogoryDbInternal;
  }

  ValueNotifier<List<CatogoryModel>> incomeCatogoryListtner = ValueNotifier([]);
  ValueNotifier<List<CatogoryModel>> expenseCatogoryListener =
      ValueNotifier([]);
  ValueNotifier<List<CatogoryModel>> toatalCatogoryListener = ValueNotifier([]);
  ValueNotifier<List<BudgetModel>> budgetValueNofifyListener =
      ValueNotifier([]);

  @override
  Future<void> insertCatogory(CatogoryModel value) async {
    final box = await Hive.openBox<CatogoryModel>('catogory');
    await box.put(value.id, value);
    if(value.type==CatogoryType.expense){
          final bBox=await Hive.openBox<BudgetModel>('budget');
    await bBox.put(value.id, BudgetModel(catogoryModel: value, budget: 0, selected: false));

    }

    refreshUi();
  }

  Future<void> budgetRefresh() async {
    budgetValueNofifyListener.value.clear();
    final bBox=await Hive.openBox<BudgetModel>('budget');
    Future.forEach(bBox.values, (element){
      budgetValueNofifyListener.value.add(element);
    });

    budgetValueNofifyListener.notifyListeners();

  }
  Future<double> budgetCalc(BudgetModel budgetModel)async{
    var dateTime = DateTime.now();
    var thisMonth = DateTime(dateTime.year, dateTime.month, 1);
    final tBox=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    double sum=0;
    Future.forEach(tBox.values, (element){
      if(element.catogoryModel.name==budgetModel.catogoryModel.name && (element.dateTime.isAfter(thisMonth) || element.dateTime==DateTime.now())){
        sum+=element.amount;
      }
    });
    return sum;

  }

  Future<void> budgetSet(BudgetModel budgetModel) async{
    final bBox=await Hive.openBox<BudgetModel>('budget');
    await bBox.put(budgetModel.catogoryModel.id, budgetModel);
    budgetRefresh();
  }

  Future<void> undifinedInitial() async {
    final box = await Hive.openBox<CatogoryModel>('catogory');
    if (box.values.isEmpty) {
      box.add(CatogoryModel(
          id: 'undifined',
          name: 'undifined',
          type: CatogoryType.undifined,
          isDeleted: false));
    }
  }

  @override
  Future<List<CatogoryModel>> getCatogory() async {
    final box = await Hive.openBox<CatogoryModel>('catogory');
    return box.values.toList();
  }

  Future<void> refreshUi() async {
    final catogoryDB = await getCatogory();
    incomeCatogoryListtner.value.clear();
    expenseCatogoryListener.value.clear();
    toatalCatogoryListener.value.clear();

    await Future.forEach(catogoryDB, (element) {
      toatalCatogoryListener.value.add(element);
      if (element.type == CatogoryType.income) {
        incomeCatogoryListtner.value.add(element);
      } else if (element.type == CatogoryType.expense) {
        expenseCatogoryListener.value.add(element);
      }
    });
    incomeCatogoryListtner.notifyListeners();
    expenseCatogoryListener.notifyListeners();
    toatalCatogoryListener.notifyListeners();
    budgetValueNofifyListener.notifyListeners();
    budgetRefresh();
  }

  Future<void> delteCatogory(CatogoryModel catogoryModel) async {
    final box = await Hive.openBox<CatogoryModel>('catogory');
    await box.delete(catogoryModel.id);

        final bBox=await Hive.openBox<BudgetModel>('budget');
        await bBox.delete(catogoryModel.id);
    
    final tBox = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    await Future.forEach(tBox.values, (element) {
      if (element.catogoryModel.name == catogoryModel.name) {
        element.catogoryType = CatogoryType.undifined;
        element.catogoryModel.name = 'undifined';
        element.catogoryModel.type = CatogoryType.undifined;
        element.catogoryModel.id = 'undifined';
        tBox.put(element.id, element);
      }
    });

    refreshUi();
  }

  //rathri matye error inde put mele akiyathan

  Future<void> editCatogory(CatogoryModel val) async {
    final box = await Hive.openBox<CatogoryModel>('catogory');
    await box.put(val.id, val);
    final tBox = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await Future.forEach(tBox.values, (element) {
      if (element.catogoryModel.id == val.id) {
        element.catogoryModel.name = val.name;
        tBox.put(element.id, element);
      }
    });

    final bBox=await Hive.openBox<BudgetModel>('budget');
      await Future.forEach(bBox.values, (element) {
      if (element.catogoryModel.id == val.id) {
        element.catogoryModel.name = val.name;
        bBox.put(element.catogoryModel.id, element);
      }
    });

    refreshUi();
  }

//when search catogory

  Future<void> seearchRefresh(String name) async {
    final catogoryDB = await getCatogory();
    incomeCatogoryListtner.value.clear();
    expenseCatogoryListener.value.clear();
    await Future.forEach(catogoryDB, (element) {
      if (element.type == CatogoryType.income &&
          element.name.toLowerCase().contains(name.toLowerCase())) {
        incomeCatogoryListtner.value.add(element);
      } else if (element.type == CatogoryType.expense &&
          element.name.contains(name)) {
        expenseCatogoryListener.value.add(element);
      }
    });
    incomeCatogoryListtner.notifyListeners();
    expenseCatogoryListener.notifyListeners();
  }

  Future<void> changeCatogoryOnDelete(String id) async {}
}
