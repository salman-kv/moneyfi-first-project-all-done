import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanager/db/model/catogory/catogory_model.dart';
import 'package:moneymanager/db/model/transaction/transaction_model.dart';
import 'package:moneymanager/db/model/graph/graph_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';
const deletedDbName = 'deleted-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel transactionModel);
  Future<List<TransactionModel>> getTransaction();
  // Future<void> deleteTransaction(String id);
  // Future<void> softDeleteTransaction(TransactionModel transactionModel);
}

class TransactionDb implements TransactionDbFunctions {
  DateTime? startDateFilter = DateTime.now();
  ValueNotifier<List<TransactionModel>> allTransactionListener =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> incomeTransactionListener =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> expenceTransactionListener =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> deletedTransactionListener =
      ValueNotifier([]);
  ValueNotifier<List<GraphModel>> graphDataListene = ValueNotifier([]);

  TransactionDb._initiate();
  static TransactionDb instance = TransactionDb._initiate();
  factory TransactionDb() {
    return instance;
  }

  @override
  Future<void> addTransaction(TransactionModel transactionModel) async {
    final box = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await box.put(transactionModel.id, transactionModel);
    refreshUi();
  }

  @override
  Future<List<TransactionModel>> getTransaction() async {
    final box = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return box.values.toList();
  }

  Future<void> refreshUi() async {
    allTransactionListener.value.clear();
    incomeTransactionListener.value.clear();
    expenceTransactionListener.value.clear();
    final values = await getTransaction();
    // values.forEach((element) {
    //   print(element.porpose);
    // });
    await Future.forEach(
      values,
      (element) {
        allTransactionListener.value.add(element);
        if (element.catogoryType == CatogoryType.income) {
          incomeTransactionListener.value.add(element);
        }
        if (element.catogoryType == CatogoryType.expense) {
          expenceTransactionListener.value.add(element);
        }
      },
    );
    List<TransactionModel> temp = [];

    temp.addAll(allTransactionListener.value);
    temp.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    print(temp[0].dateTime);
    startDateFilter = temp[0].dateTime;

    allTransactionListener.notifyListeners();
    incomeTransactionListener.notifyListeners();
    expenceTransactionListener.notifyListeners();
  }

  Future<void> serarchrefreshUi(String name) async {
    List<TransactionModel> values = await getTransaction();
    values.addAll(allTransactionListener.value);
    allTransactionListener.value.clear();
    incomeTransactionListener.value.clear();
    expenceTransactionListener.value.clear();

    await Future.forEach(values, (element) {
      if (element.porpose.contains(name)) {
        allTransactionListener.value.add(element);
      }
      if (element.catogoryType == CatogoryType.income &&
          element.porpose.contains(name)) {
        incomeTransactionListener.value.add(element);
      }
      if (element.catogoryType == CatogoryType.expense &&
          element.porpose.contains(name)) {
        expenceTransactionListener.value.add(element);
      }
    });

    allTransactionListener.notifyListeners();
    incomeTransactionListener.notifyListeners();
    expenceTransactionListener.notifyListeners();
  }

  Future<void> deleteRefresh() async {
    deletedTransactionListener.value.clear();
    final deletedBox = await Hive.openBox<TransactionModel>(deletedDbName);
    Future.forEach(deletedBox.values, (element) {
      deletedTransactionListener.value.add(element);
    });
    deletedTransactionListener.notifyListeners();
    allTransactionListener.notifyListeners();
    incomeTransactionListener.notifyListeners();
    expenceTransactionListener.notifyListeners();
    refreshUi();
  }

  Future<void> deleteTransaction(TransactionModel transactionModel) async {
    final deletedBox = await Hive.openBox<TransactionModel>(deletedDbName);
    transactionModel.deleteDate=DateTime.now().add(Duration(days: 30));
    deletedBox.put(transactionModel.id, transactionModel);
    final box = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    box.delete(transactionModel.id);
    deleteRefresh();
  }

  Future<void> deleteTransactionFromDelete(
      TransactionModel transactionModel) async {
    final deletedBox = await Hive.openBox<TransactionModel>(deletedDbName);
    deletedBox.delete(transactionModel.id);
    deleteRefresh();
  }

  Future<void> restoreDeletedTransaction(
      TransactionModel transactionModel) async {
    final box = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    box.put(transactionModel.id, transactionModel);
    final deletedBox = await Hive.openBox<TransactionModel>(deletedDbName);
    deletedBox.delete(transactionModel.id);
    deleteRefresh();
  }

  Future<void> deleteAfterOneMonth()async{
    deletedTransactionListener.value.forEach((element) {
      if(element.deleteDate!.isBefore(DateTime.now())){
        deleteTransactionFromDelete(element);
      }
    });
  }

  Future<void> filterRefresh(int typeOfFilter) async {
    switch (typeOfFilter) {
      case 0:
        refreshUi();
      case 1:
        allTransactionListener.value
            .sort((a, b) => a.amount.compareTo(b.amount));
        incomeTransactionListener.value
            .sort((a, b) => a.amount.compareTo(b.amount));
        expenceTransactionListener.value
            .sort((a, b) => a.amount.compareTo(b.amount));
        allTransactionListener.notifyListeners();
        incomeTransactionListener.notifyListeners();
        expenceTransactionListener.notifyListeners();

      case 2:
        allTransactionListener.value
            .sort((b, a) => a.amount.compareTo(b.amount));
        incomeTransactionListener.value
            .sort((b, a) => a.amount.compareTo(b.amount));
        expenceTransactionListener.value
            .sort((b, a) => a.amount.compareTo(b.amount));

        allTransactionListener.notifyListeners();
        incomeTransactionListener.notifyListeners();
        expenceTransactionListener.notifyListeners();

      case 3:
        allTransactionListener.value
            .sort((a, b) => a.dateTime.compareTo(b.dateTime));
        incomeTransactionListener.value
            .sort((a, b) => a.dateTime.compareTo(b.dateTime));
        expenceTransactionListener.value
            .sort((a, b) => a.dateTime.compareTo(b.dateTime));

        allTransactionListener.notifyListeners();
        incomeTransactionListener.notifyListeners();
        expenceTransactionListener.notifyListeners();
      case 4:
        allTransactionListener.value
            .sort((b, a) => a.dateTime.compareTo(b.dateTime));
        incomeTransactionListener.value
            .sort((b, a) => a.dateTime.compareTo(b.dateTime));
        expenceTransactionListener.value
            .sort((b, a) => a.dateTime.compareTo(b.dateTime));

        allTransactionListener.notifyListeners();
        incomeTransactionListener.notifyListeners();
        expenceTransactionListener.notifyListeners();
    }
  }

  // Future<void> graphSum() async {
  //   graphDataListene.value.clear();
  //   double sumIncome = 0;
  //   double sumExpense = 0;
  //   allTransactionListener.value.forEach((element) {
  //     if (element.catogoryType == CatogoryType.income) {
  //       sumIncome += element.amount;
  //     } else {
  //       sumExpense += element.amount;
  //     }
  //   });
  //   var val = GraphModel(sum: sumIncome, name: 'Income');
  //   var val1 = GraphModel(sum: sumExpense, name: 'Expence');
  //   graphDataListene.value.add(val);
  //   graphDataListene.value.add(val1);
  //   graphDataListene.notifyListeners();
  // }

  Future<void> transactionFilterOnlyDate(
      DateTime startDate, DateTime endDate) async {
    await refreshUi();
    List<TransactionModel> tempFilter = [];
    tempFilter.addAll(allTransactionListener.value);
    // tempFilter.forEach((element) {print(element.porpose);});

    expenceTransactionListener.value.clear();
    incomeTransactionListener.value.clear();

    allTransactionListener.value.clear();
    Future.forEach(tempFilter, (element) {
      if ((element.dateTime.isBefore(endDate) &&
              element.dateTime.isAfter(startDate)) ||
          element.dateTime == startDate ||
          element.dateTime == endDate) {
        allTransactionListener.value.add(element);
        if (element.catogoryType == CatogoryType.income) {
          incomeTransactionListener.value.add(element);
        } else {
          expenceTransactionListener.value.add(element);
        }
      } else {
        print('not enter --- ${element.porpose}');
      }
    });

    allTransactionListener.notifyListeners();
    expenceTransactionListener.notifyListeners();
    incomeTransactionListener.notifyListeners();
  }

  Future<void> transactionFilterWithCatogory(
      DateTime startDate, DateTime endDate, String catogory) async {
    await refreshUi();
    List<TransactionModel> tempFilter = [];
    tempFilter.addAll(allTransactionListener.value);

    expenceTransactionListener.value.clear();
    incomeTransactionListener.value.clear();
    allTransactionListener.value.clear();

    Future.forEach(tempFilter, (element) {
      if ((element.dateTime.isBefore(endDate) &&
              element.dateTime.isAfter(startDate) &&
              element.catogoryModel.name == catogory) ||
          (element.dateTime == startDate &&
              element.catogoryModel.name == catogory) ||
          (element.dateTime == endDate &&
              element.catogoryModel.name == catogory)) {
        allTransactionListener.value.add(element);

        if (element.catogoryType == CatogoryType.income) {
          incomeTransactionListener.value.add(element);
        } else {
          expenceTransactionListener.value.add(element);
        }
      }
    });

    allTransactionListener.notifyListeners();
    expenceTransactionListener.notifyListeners();
    incomeTransactionListener.notifyListeners();
  }

  List<GraphModel> incomeExpenceMonthlyTotal() {
    var dateTime = DateTime.now();
    var thisMonth = DateTime(dateTime.year, dateTime.month, 1);

    var iSum = 0.0;
    var eSum = 0.0;
    List<GraphModel> returnList = [];

    TransactionDb().allTransactionListener.value.forEach((element) {
      if (element.catogoryType == CatogoryType.income &&
          (element.dateTime.isAfter(thisMonth) ||
              element.dateTime == thisMonth)) {
        iSum += element.amount;
      } else if (element.catogoryType == CatogoryType.expense &&
          (element.dateTime.isAfter(thisMonth) ||
              element.dateTime == thisMonth)) {
        eSum += element.amount;
      }
      // else{
      //   uSum+=element.amount;
      // }
    });
    returnList.add(GraphModel(sum: iSum, name: 'Income'));
    returnList.add(GraphModel(sum: eSum, name: 'Expense'));
    return returnList;
  }
}





    // tempFilter.forEach((element) {
    //   print('sdaf');
    //   if ((element.dateTime.isBefore(endDate) &&
    //           element.dateTime.isAfter(startDate)) ||
    //       element.dateTime == startDate ||
    //       element.dateTime == endDate) {
    //     allTransactionListener.value.add(element);
    //     if (element.catogoryType == CatogoryType.income) {
    //       incomeTransactionListener.value.add(element);
    //     } else {
    //       expenceTransactionListener.value.add(element);
    //     }
    //   }
    // });
