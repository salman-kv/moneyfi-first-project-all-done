import 'package:moneymanager/db/function/catogory/catogory_db.dart';
import 'package:moneymanager/db/function/transaction/transaction_db.dart';
import 'package:moneymanager/db/model/catogory/catogory_model.dart';

class GraphModel {
  double sum;
  String name;
  GraphModel({required this.sum, required this.name});
}

List<GraphModel> getGraph() {
  int i = 0;
  List<GraphModel> returnList = [];
  while (i < CatogoryDb().toatalCatogoryListener.value.length) {
    double sum = 0;
    TransactionDb().allTransactionListener.value.forEach((element) {
      if (CatogoryDb().toatalCatogoryListener.value[i].name ==
          element.catogoryModel.name) {
        sum += element.amount;
      }
    });
    returnList.add(GraphModel(
        sum: sum, name: CatogoryDb().toatalCatogoryListener.value[i].name));
    i++;
  }
  return returnList.reversed.toList();
}

List<GraphModel> getGraphIEOnly(){
List<GraphModel> returnList = [];
var iSum=0.0;
var eSum=0.0;
// var uSum=0.0;

  TransactionDb().allTransactionListener.value.forEach((element) {
    print('yes');
      if (element.catogoryType==CatogoryType.income) {
        iSum += element.amount;
      }
      else if(element.catogoryType==CatogoryType.expense){
        eSum+=element.amount;
      }
      // else{
      //   uSum+=element.amount;
      // }
    });
    print(iSum);
    returnList.add(GraphModel(sum: iSum, name: 'Income'));
    returnList.add(GraphModel(sum: eSum, name: 'Expense'));
    // returnList.add(GraphModel(sum: uSum, name: 'undifined'));
    return returnList;

}


