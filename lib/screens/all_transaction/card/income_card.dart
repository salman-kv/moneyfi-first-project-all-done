import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager/db/function/transaction/transaction_db.dart';
import 'package:moneymanager/db/model/catogory/catogory_model.dart';
import 'package:moneymanager/db/model/transaction/transaction_model.dart';
import 'package:moneymanager/screens/all_transaction/edit_transaction.dart';
import 'package:moneymanager/screens/catogory/catogory_income.dart';
import 'package:moneymanager/theme/theme_constants.dart';
import 'package:recase/recase.dart';

class IncomeCard extends StatelessWidget {
  final textTheme;

  const IncomeCard({required this.textTheme, super.key});

  @override
  Widget build(BuildContext context) {
    // final _textTheme = textTheme;
    return Column(
      children: [
        // Search(),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: TransactionDb().incomeTransactionListener,
            builder: (BuildContext context, List<TransactionModel> newList, _) {
              return newList.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (ctx, index) {
                        return incomeCard(context, newList.reversed.toList()[index]);
                      },
                      itemCount: newList.length,
                    )
                  : Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 80,
                            width: 80,
                            child:
                                Image.asset('assets/images/notransaction.png')),
                        Text(
                          'No Transaction Found',
                          style: TextStyle(
                              color: expenseColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ],
                    ));
            },
          ),
        )
      ],
    );
  }

    Widget incomeCard(BuildContext context, TransactionModel transactionModel) {
    final _textTheme = textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onLongPress: () {
          longpress(context, transactionModel);
        },
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 141, 141, 141),
                blurRadius: 4,
                offset: Offset(0, 1),
                blurStyle: BlurStyle.normal,
              )
            ],
            image: DecorationImage(
                image: AssetImage('assets/images/grid.png'), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          padding: const EdgeInsets.all(7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 246, 246, 246),
                ),
                margin: const EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${transactionModel.dateTime.day}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      DateFormat.MMM().format(transactionModel.dateTime),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactionModel.porpose.titleCase,
                      maxLines: 3,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text(
                      transactionModel.catogoryModel.name.titleCase,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color:
                            transactionModel.catogoryType == CatogoryType.income
                                ? incomeColor
                                : transactionModel.catogoryType ==
                                        CatogoryType.expense
                                    ? expenseColor
                                    : const Color.fromARGB(255, 255, 255, 255),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        '₹${transactionModel.amount}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                      transactionModel.catogoryType == CatogoryType.income
                          ? Icon(
                              Icons.arrow_upward_rounded,
                              color: incomeColor,
                              size: 17,
                            )
                          : transactionModel.catogoryType==CatogoryType.expense ?Icon(Icons.arrow_downward,color: expenseColor,size: 17,) :const SizedBox()
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
    }
  //  Widget incomeCard(BuildContext context, TransactionModel transactionModel) {
  //   final _textTheme = textTheme;
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: GestureDetector(
  //       onLongPress: () {
  //         longpress(context, transactionModel);
  //       },
  //       child: Container(
  //         decoration: BoxDecoration(
  //           boxShadow: const [
  //             BoxShadow(
  //               color: Color.fromARGB(255, 141, 141, 141),
  //               blurRadius: 4,
  //               offset: Offset(0, 1),
  //               blurStyle: BlurStyle.normal,
  //             )
  //           ],
  //           borderRadius: const BorderRadius.all(Radius.circular(10)),
  //           color: containerColor,
  //         ),
  //         padding: const EdgeInsets.all(8),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Container(
  //               width: 50,
  //               height: 50,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(100),
  //                 color: const Color.fromARGB(50, 4, 45, 114),
  //               ),
  //               margin: const EdgeInsets.all(0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     '${transactionModel.dateTime.day}',
  //                     style: _textTheme.bodyLarge,
  //                   ),
  //                   Text(
  //                     DateFormat.MMM().format(transactionModel.dateTime),
  //                     style: _textTheme.bodyLarge,
  //                   )
  //                 ],
  //               ),
  //             ),
  //             const SizedBox(
  //               width: 5,
  //             ),
  //             Expanded(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(transactionModel.porpose.titleCase,
  //                       maxLines: 3,
  //                       style: const TextStyle(
  //                           fontSize: 22, fontWeight: FontWeight.w500)),
  //                   Text(
  //                     transactionModel.catogoryModel.name.titleCase,
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.w500,
  //                       fontSize: 16,
  //                       color:
  //                           transactionModel.catogoryType == CatogoryType.income
  //                               ? incomeColor
  //                               : transactionModel.catogoryType ==
  //                                       CatogoryType.expense
  //                                   ? expenseColor
  //                                   : const Color.fromARGB(255, 20, 77, 124),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),

  //             Container(
  //               height: 50,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               child: Center(
  //                 child: Text(
  //                   '${transactionModel.amount}',
  //                   style: TextStyle(
  //                       color:
  //                           transactionModel.catogoryType == CatogoryType.income
  //                               ? incomeColor
  //                               : transactionModel.catogoryType ==
  //                                       CatogoryType.expense
  //                                   ? expenseColor
  //                                   : Color.fromARGB(255, 20, 77, 124),
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 20),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(
  //               width: 10,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

Future<void> longpress(BuildContext context,TransactionModel transactionModel) {
  return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title:const Text(
            'Delete or Edit',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) {
                    return  EditTransactionScreen(transactionModel: transactionModel,);
                  }));
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.edit,
                )),
            IconButton(
                onPressed: () async {
                  TransactionDb().deleteTransaction(transactionModel);
                  Navigator.of(context).pop();
                  catogoryDeleteSnackBar(context, 'Transaction'); 
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ],
        );
      }));
}