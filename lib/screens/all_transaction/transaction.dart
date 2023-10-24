import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moneymanager/db/function/transaction/transaction_db.dart';
import 'package:moneymanager/screens/all_transaction/add_transaction.dart';
import 'package:moneymanager/screens/all_transaction/all_transaction_screen.dart';
import 'package:moneymanager/screens/all_transaction/expense_screen.dart';
import 'package:moneymanager/screens/all_transaction/income_screen.dart';
import 'package:moneymanager/screens/all_transaction/sort_filter/filter.dart';
import 'package:moneymanager/screens/all_transaction/sort_filter/sort.dart';
import 'package:moneymanager/screens/common_widget/search.dart';
import 'package:moneymanager/theme/theme_constants.dart';

ValueNotifier<int> selectListener = ValueNotifier(0);
ValueNotifier<DateTime> transactionFilterStartDate =
    ValueNotifier(TransactionDb().startDateFilter!);
ValueNotifier<DateTime> transactionFilterEndDate =
    ValueNotifier(DateTime.now());
ValueNotifier<String> transactionFilterSelectedCatogory = ValueNotifier('');
ValueNotifier<int> transactionFilterSelectedCatogoryIndex = ValueNotifier(-1);

class AllTransactionScreen extends StatefulWidget {
  const AllTransactionScreen({super.key});

  @override
  State<AllTransactionScreen> createState() => _AllTransactionState();
}

class _AllTransactionState extends State<AllTransactionScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller = TabController(length: 3, vsync: this);

  int selectedpage = 0;

  @override
  void initState() {
    TransactionDb().refreshUi();
    selectListener.value = 0;
    transactionFilterStartDate.value = TransactionDb().startDateFilter!;
    transactionFilterSelectedCatogory.value = '';
    transactionFilterSelectedCatogoryIndex.value = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
              floatingActionButton: CircleAvatar(
                radius: 30,
                backgroundColor:mainColor,
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                      return const TransactionScreen();
                    }));
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              appBar: TabBar(
                  onTap: (value) {
                    setState(() {
                      selectedpage = value;
                      TransactionDb().refreshUi();
                      selectListener.value = 0;
                      transactionFilterStartDate.value =
                          TransactionDb().startDateFilter!;
                      transactionFilterEndDate.value = DateTime.now();
                      transactionFilterSelectedCatogory.value = '';
                      transactionFilterSelectedCatogoryIndex.value = -1;
                    });
                  },
                  indicatorColor: Colors.black,
                  controller: _controller,
                  tabs: const [
                    SizedBox(
                        height: 50,
                        child: Center(
                            child: Text(
                          'ALL',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ))),
                    SizedBox(
                        height: 50,
                        child: Center(
                            child: Text(
                          'INCOME',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ))),
                    SizedBox(
                        height: 50,
                        child: Center(
                            child: Text(
                          'EXPENSE',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ))),
                  ]),
              body: Column(
                children: [
                  Search(),
                  Expanded(
                    child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _controller,
                        children: const [
                          AllTransaction(),
                          IncomeScreen(),
                          ExpenseScreen(),
                          // DeletedScreen()
                        ]),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      bottemSort(context, size, _textTheme);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.sort,
                      size: 20,
                      color: Colors.black,
                    ),
                    label: const Text(
                      'Sort',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: .5,
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      bottemFilter(context, size, _textTheme, selectedpage);
                    },
                    icon: const Icon(
                      Icons.filter_list,
                      size: 25,
                      color: Colors.black,
                    ),
                    label: const Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.035,
          ),
        ],
      ),
    );
  }

  bottemSort(BuildContext context, Size size, TextTheme textTheme) {
    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return SingleChildScrollView(
            child: SizedBox(
              height: size.height * 0.4 ,
              child: TransactionSort(selectedListener: selectListener.value),
            ),
          );
        });
  }
}

bottemFilter(
    BuildContext context, Size size, TextTheme textTheme, int selectedpage) {
  return showModalBottomSheet(
    shape:const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
    ),
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: MediaQuery.of(context).orientation==Orientation.portrait ? size.height *0.35 : size.height *0.6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TransactionFilter(selectedpage: selectedpage),
          ),
        );
      });
}
