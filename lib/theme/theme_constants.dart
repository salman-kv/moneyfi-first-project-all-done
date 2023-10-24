
import 'package:flutter/material.dart';
Color containerColor=const Color.fromARGB(255, 234, 234, 234);
Color expenseColor=const Color.fromARGB(255,200, 102, 96,);
Color incomeColor=Color.fromARGB(255, 104, 181, 126);
Color mainColor=const Color.fromARGB(250,255, 247, 241);
Color backgroundPurple=Color.fromARGB(255, 255, 255, 255);


ThemeData lightTheme=ThemeData(
  
  brightness: Brightness.light,
  primarySwatch:Colors.blueGrey,
  primaryColor:const Color.fromARGB(255, 231, 226, 226),
  fontFamily:'archivo narrow',
  scaffoldBackgroundColor:Color.fromARGB(250,255, 247, 241),
  textTheme:const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold
    )
  )
  







);
ThemeData darkTheme=ThemeData(
  
  brightness: Brightness.dark,
  primaryColor:const Color.fromARGB(255, 235, 235, 235),
  fontFamily:'archivo narrow'

);