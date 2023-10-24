import 'package:flutter/material.dart';
import 'package:moneymanager/screens/all_transaction/card/all_card.dart';
class AllTransaction extends StatelessWidget {
  const AllTransaction({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:   AllCard(textTheme: Theme.of(context).textTheme),
      ),
    );
  }
}