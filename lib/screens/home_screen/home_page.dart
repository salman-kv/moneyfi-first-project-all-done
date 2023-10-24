import 'package:flutter/material.dart';
import 'package:moneymanager/db/function/catogory/catogory_db.dart';
import 'package:moneymanager/db/function/transaction/transaction_db.dart';
import 'package:moneymanager/screens/home_screen/add_target.dart';
import 'package:moneymanager/screens/home_screen/single_card.dart';
import 'package:moneymanager/screens/home_screen/target_widget.dart';
import 'package:moneymanager/screens/home_screen/total_income_expense.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    CatogoryDb().refreshUi();
    CatogoryDb().undifinedInitial();
    refreshTarget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransactionDb().refreshUi();
    TextTheme _textTheme = Theme.of(context).textTheme;
    Size size=MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color.fromARGB(250,255, 247, 241)
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: size.width * .8,
                  constraints: BoxConstraints(
                    minHeight:  size.height * .23,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(image: AssetImage('assets/images/card.png'),fit: BoxFit.cover),
                    boxShadow:const [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(2, 5)
                      )
                    ]
                  ),
                  child: const TotalIncomeExpense(),
                ),
              ),
               const  Padding(
                padding:  EdgeInsets.all(8.0),
                child:  Text(
                      'My Target',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(175, 0, 0, 0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              ),
              const TargetWidget(),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Recent Transaction',
                      style: _textTheme.titleMedium
                          ?.copyWith(color: const  Color.fromARGB(201, 32, 30, 30)),
                    ),
                  ),
                ],
              ),
              SingleCard(
                textTheme: Theme.of(context).textTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
