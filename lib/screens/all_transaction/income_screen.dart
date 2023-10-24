import 'package:flutter/material.dart';
import 'package:moneymanager/screens/all_transaction/card/income_card.dart';
import 'package:moneymanager/screens/all_transaction/transaction.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     selectListener.value=0;
    return SafeArea(
      child: Scaffold(
        body: IncomeCard(textTheme: Theme.of(context).textTheme),
      ),
    );
  }
}
