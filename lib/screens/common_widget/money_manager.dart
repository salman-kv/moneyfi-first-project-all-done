import 'package:flutter/material.dart';
import 'package:moneymanager/theme/theme_constants.dart';

Widget moneymanager(double fsize){
  return  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'MONEY',
        style: TextStyle(
          fontFamily: 'irish',
          fontSize: fsize ,
          // color: const Color.fromARGB(255, 198, 180, 20),
          color: incomeColor
        ),
      ),
       SizedBox(width: fsize/2,),
      Text(
        'MANAGER',
        style: TextStyle(
          fontFamily: 'irish',
          fontSize: fsize,
          // color: Colors.black
          color: expenseColor
        ),
      ),
    ],
  );
}