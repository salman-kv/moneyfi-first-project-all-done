import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanager/db/model/budget_model/budget_model.dart';
import 'package:moneymanager/db/model/catogory/catogory_model.dart';
import 'package:moneymanager/db/model/target/target_model.dart';
import 'package:moneymanager/db/model/transaction/transaction_model.dart';
import 'package:moneymanager/screens/splash_screen.dart';
import 'package:moneymanager/theme/theme_constants.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CatogoryModelAdapter().typeId)) {
    Hive.registerAdapter(CatogoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CatogoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CatogoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TargetModelOfMoneyAdapter().typeId)) {
    Hive.registerAdapter(TargetModelOfMoneyAdapter());
  }
  if (!Hive.isAdapterRegistered(BudgetModelAdapter().typeId)) {
    Hive.registerAdapter(BudgetModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Manager',
      theme: lightTheme,
      home: const SplashScreen(),
    );
  }
}
