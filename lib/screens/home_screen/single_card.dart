import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager/db/function/transaction/transaction_db.dart';
import 'package:moneymanager/db/model/catogory/catogory_model.dart';
import 'package:moneymanager/db/model/transaction/transaction_model.dart';
import 'package:moneymanager/screens/all_transaction/card/income_card.dart';
import 'package:moneymanager/theme/theme_constants.dart';

import 'package:recase/recase.dart';

class SingleCard extends StatefulWidget {
  final TextTheme textTheme;
  const SingleCard({required this.textTheme, super.key});

  @override
  State<SingleCard> createState() => _SingleCardState();
}

class _SingleCardState extends State<SingleCard> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    var m = MediaQuery.of(context).orientation;
    return ValueListenableBuilder(
      valueListenable: TransactionDb().allTransactionListener,
      builder: (BuildContext context, List<TransactionModel> newList, _) {
        return newList.isEmpty
            ? SizedBox(
              width: double.infinity,
              height:size.height *.4 ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset('assets/images/notransaction.png')),
                  Text(
                  'no data found',
                  style: TextStyle(color: expenseColor,fontWeight: FontWeight.w600,fontSize: 16),
                ),
                ],
              ),
            )
            : GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: m == Orientation.portrait ? 1 / 1.2 : 1 / 1.5,
                crossAxisCount: m == Orientation.portrait ? 2 : 4,
                children: List.generate(
                    newList.length > 10 ? 10 : newList.length, (index) {
                  return singleCard(newList.reversed.toList()[index]);
                }));
      },
    );
  }

  Widget singleCard(TransactionModel transactionModel) {
    TextTheme _textTheme = widget.textTheme;
    return GestureDetector(
      onLongPress: () {
        longpress(context, transactionModel);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: AssetImage('assets/images/grid.png'),fit: BoxFit.cover)
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transactionModel.porpose.titleCase,
                  style: _textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 20),
                ),
                Text(
                  transactionModel.catogoryModel.name.titleCase,
                  style: _textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 154, 154, 154)),
                ),
                Text(
                  ('₹${transactionModel.amount.toString()}'),
                  style: _textTheme.titleLarge?.copyWith(
                      // fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: const Color.fromARGB(214, 255, 255, 255)),
                ),
              ],
            ),
            Center(
                child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: Color.fromARGB(255, 1, 40, 54),
                color: const Color.fromARGB(128, 56, 56, 48)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${transactionModel.dateTime.day}',
                    style: _textTheme.bodyLarge?.copyWith(
                        color:const Color.fromARGB(255, 171, 169, 162)),
                  ),
                  Text(
                    DateFormat.MMM().format(transactionModel.dateTime),
                    style: _textTheme.bodyLarge?.copyWith(
                        color:const Color.fromARGB(255, 171, 169, 162)),
                  ),
                ],
              ),
            )),
            Center(
                child: transactionModel.catogoryType == CatogoryType.income
                    ? SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset(
                          'assets/images/profits.png',
                        ),
                      )
                    : transactionModel.catogoryType == CatogoryType.expense
                        ? SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.asset(
                              'assets/images/loss.png',
                            ),
                          )
                        : SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.asset(
                              'assets/images/neutral.png',
                            ),
                          )),
            // SizedBox(
            //     width: double.infinity,
            //     child: transactionModel.catogoryType == CatogoryType.income
            //         ? Text(
            //             'Income',
            //             textAlign: TextAlign.center,
            //             style: _textTheme.titleMedium?.copyWith(
            //                 fontWeight: FontWeight.w600, color: incomeColor),
            //           )
            //         : transactionModel.catogoryType == CatogoryType.expense
            //             ? Text(
            //                 'Expense',
            //                 textAlign: TextAlign.center,
            //                 style: _textTheme.titleMedium?.copyWith(
            //                     fontWeight: FontWeight.w600,
            //                     color: expenseColor),
            //               )
            //             : Text(
            //                 'Undifined',
            //                 textAlign: TextAlign.center,
            //                 style: _textTheme.titleMedium?.copyWith(
            //                     fontWeight: FontWeight.w600,
            //                     color:Color.fromARGB(255, 242, 242, 242)),
            //               )),
          ],
        ),
      ),
    );
  }
}
