import 'package:flutter/material.dart';
import 'package:moneymanager/db/function/catogory/catogory_db.dart';
import 'package:moneymanager/db/model/catogory/catogory_model.dart';
import 'package:moneymanager/screens/catogory/add_catogory.dart';
import 'package:moneymanager/screens/catogory/catogory_card.dart';
import 'package:moneymanager/screens/common_widget/search.dart';
import 'package:moneymanager/theme/theme_constants.dart';

class CatogoryIncome extends StatefulWidget {
  const CatogoryIncome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CatogoryIncome>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    CatogoryDb().refreshUi();
    super.initState();
  }

  late final TabController _controller = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        onTap: (value) {
          setState(() {
            CatogoryDb().refreshUi();
          });
        },
        controller: _controller,
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
          width: 3,
          color: _controller.index == 0 ? incomeColor : expenseColor,
        )),
        indicatorColor: _controller.index == 0 ? incomeColor : expenseColor,
        tabs: [
          Tab(
            child: Text(
              'INCOME',
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: incomeColor),
            ),
          ),
          Tab(
            child: Text(
              'EXPENSE',
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: expenseColor),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Search(),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: [
                ValueListenableBuilder(
                    valueListenable: CatogoryDb().incomeCatogoryListtner,
                    builder:
                        (BuildContext context, List<CatogoryModel> newList, _) {
                      return newList.isNotEmpty
                          ? ListView(
                              children: List.generate(newList.length, (index) {
                              return CatogoryCard(
                                textTheme: Theme.of(context).textTheme,
                                singleList: newList.reversed.toList()[index],
                              );
                            }))
                          : Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Image.asset(
                                        'assets/images/notransaction.png')),
                                Text(
                                  'No Income Catogory Found',
                                  style: TextStyle(
                                      color: expenseColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ],
                            ));
                    }),
                ValueListenableBuilder(
                    valueListenable: CatogoryDb().expenseCatogoryListener,
                    builder:
                        (BuildContext context, List<CatogoryModel> newList, _) {
                      return newList.isNotEmpty
                          ? ListView(
                              children: List.generate(newList.length, (index) {
                              return CatogoryCard(
                                textTheme: Theme.of(context).textTheme,
                                singleList: newList.reversed.toList()[index],
                              );
                            }))
                          : Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Image.asset(
                                        'assets/images/notransaction.png')),
                                Text(
                                  'No Expence Catogory Found',
                                  style: TextStyle(
                                      color: expenseColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ],
                            ));
                    }),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 45,
        width: 45,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              if (_controller.index == 0) {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return AddCatogory(
                    type: CatogoryType.income,
                  );
                }));
              } else {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return AddCatogory(
                    type: CatogoryType.expense,
                  );
                }));
              }
            },
            backgroundColor:
                _controller.index == 0 ? incomeColor : expenseColor,
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

catogoryEditSnackBar(BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text(
        'Catogory Updated',
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 2),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      behavior: SnackBarBehavior.floating,
      backgroundColor: incomeColor,
    ),
  );
}

catogoryDeleteSnackBar(BuildContext context, String name) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '$name Deleted',
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 2),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      behavior: SnackBarBehavior.floating,
      backgroundColor: expenseColor,
    ),
  );
}
