import 'package:flutter/material.dart';
import 'package:moneymanager/screens/all_transaction/card/expense_card.dart';
import 'package:moneymanager/screens/all_transaction/transaction.dart';

// import 'package:moneymanager/app_bar/custom_appbar_main.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
     selectListener.value=0;
    return SafeArea(
      child: Scaffold(
        // appBar: AllAppbar(headname: 'EXPENSE',),
        body:   ExpenseCard(textTheme: Theme.of(context).textTheme),
      ),
    );
  }
}