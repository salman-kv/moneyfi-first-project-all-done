import 'package:flutter/material.dart';
import 'package:moneymanager/db/function/catogory/catogory_db.dart';
import 'package:moneymanager/screens/app_bar/all_appbar.dart';
import 'package:moneymanager/screens/budget_screen/budget_amountsetting.dart';
import 'package:moneymanager/theme/theme_constants.dart';

class BudgetAdd extends StatelessWidget {
  const BudgetAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AllAppbar(headname: 'Budget'),
      body: ValueListenableBuilder(
        valueListenable: CatogoryDb().budgetValueNofifyListener,
        builder: (context, value, child) {
          var bu = false;
          value.forEach((element) {
            if (element.selected != false) {
              bu = true;
            }
          });

          return bu
              ? Column(
                  children: List.generate(value.length, (index) {
                    return value[index].selected == true
                        ? Container(
                            decoration: BoxDecoration(
                                color:const Color.fromARGB(255, 8, 8, 8),
                                borderRadius: BorderRadius.circular(100)),
                            padding:const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Text(
                                    value[index].catogoryModel.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  value[index].budget.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (ctx) {
                                        return BudgetAmountSetting(
                                          budgetModel: value[index],
                                        );
                                      }));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return AlertDialog(
                                              content: const Text(
                                                  'Do you want to remove this budget',style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    
                                                  ),),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'No',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    value[index].budget = 0;
                                                    value[index].selected =
                                                        false;
                                                    CatogoryDb().budgetSet(
                                                        value[index]);
                                                        Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          )
                        : const SizedBox();
                  }),
                )
              :  SizedBox(
                width: double.infinity,
                child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: Image.asset('assets/images/no budget.png')),
                          Text('No Budget',style: TextStyle(
                            color: expenseColor,
                            fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () {
            budgetAddBottomSheet(context);
          }),
    ));
  }

  Future<void> budgetAddBottomSheet(BuildContext context) async {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            constraints: BoxConstraints(minHeight: size.height * 0.3),
            child: ValueListenableBuilder(
              valueListenable: CatogoryDb().budgetValueNofifyListener,
              builder: (context, value, child) {
                var bu = false;
                value.forEach((element) {
                  if (element.selected != true) {
                    bu = true;
                  }
                });
                return bu
                    ? SingleChildScrollView(
                        child: Column(
                          children: List.generate(value.length, (index) {
                            return value[index].selected == false
                                ? Container(
                                    decoration: BoxDecoration(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.all(8),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            value[index].catogoryModel.name,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (ctx) {
                                                  return BudgetAmountSetting(
                                                    budgetModel: value[index],
                                                  );
                                                }));
                                              },
                                              // icon: const Text('Add',style: TextStyle(color: Colors.amber),),
                                              icon: Container(
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: const Icon(Icons.add),
                                              )),
                                        ]),
                                  )
                                : const SizedBox();
                          }),
                        ),
                      )
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset('assets/images/expenses.png'),
                        ),
                        Text(
                          'No catogory found',
                          style: TextStyle(color: expenseColor,fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
              },
            ),
          );
        });
  }
}
