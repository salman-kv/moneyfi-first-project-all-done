import 'package:flutter/material.dart';
import 'package:moneymanager/db/function/transaction/transaction_db.dart';

class AllAppbar extends StatelessWidget implements PreferredSizeWidget {
  final headname;
  const AllAppbar({this.headname, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    // TextTheme _textTheme=Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      height: 50,
      child: Stack(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                  TransactionDb().refreshUi();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                weight: 50,
              )),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                headname==null? '' : '$headname',
                style:const TextStyle(
                  
                  fontSize: 20,
                  fontWeight:FontWeight.w800,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
