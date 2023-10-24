import 'package:flutter/material.dart';
import 'package:moneymanager/db/function/transaction/transaction_db.dart';
import 'package:moneymanager/db/model/graph/graph_model.dart';

class TotalIncomeExpense extends StatelessWidget {
  const TotalIncomeExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder(valueListenable: TransactionDb().allTransactionListener, builder: (context, value, child) {
        List<GraphModel> ie=TransactionDb().incomeExpenceMonthlyTotal();
        var error;
        ie[0].sum-ie[1].sum <0 ? error=true : error=false;
        return  Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           Column(
             children: [
               const Text('Total Balance',style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),),
                error ?  Text('₹ ${ie[0].sum-ie[1].sum} /-',style: const TextStyle(
                  color: Color.fromARGB(255, 255, 0, 0),
                  fontSize: 40,
                  fontWeight: FontWeight.w500
                )):
                Text('₹ ${ie[0].sum-ie[1].sum} /-',style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 40,
                  fontWeight: FontWeight.w500
                )),
                error ? const Text('your expence is high !',style: TextStyle(
                  color: Colors.red
                ),) : const SizedBox(),
             ],
           ),
            Row(
            children: [
              ////////////////////////
              totalBox(context, const Color.fromARGB(255,104, 181, 176), ie[0].sum),
              const SizedBox(
                width: 10,
              ),
              totalBox(context,const Color.fromARGB(255,200, 102, 96,), ie[1].sum),
            ],
      ),
          ],
        );
      },)
      
   
    );
  }
}

Widget totalBox(ctx, Color color, double amount) {
  TextTheme _textTheme = Theme.of(ctx).textTheme;
  return Expanded(
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(blurRadius: 10,  offset: Offset(3, 3),color: const Color.fromARGB(255, 0, 0, 0),blurStyle: BlurStyle.normal)
        // ],
        borderRadius: BorderRadius.circular(100),
        color: color,
      ),
      child: Center(
          child: Text('₹$amount',
              style: _textTheme.titleLarge?.copyWith(
                color: Colors.white,
              ))),
    ),
  );
}
