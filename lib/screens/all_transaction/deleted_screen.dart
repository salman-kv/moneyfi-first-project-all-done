import 'package:flutter/material.dart';
import 'package:moneymanager/screens/all_transaction/card/deleted_card.dart';
import 'package:moneymanager/screens/all_transaction/transaction.dart';


class DeletedScreen extends StatelessWidget {
  const DeletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
     selectListener.value=0;
    return SafeArea(
      child: Scaffold(
        // appBar: AllAppbar(headname: 'DELETED TRANSACTION',),
        body:   DeletedCard(textTheme: Theme.of(context).textTheme),
      ),
    );
  }
}