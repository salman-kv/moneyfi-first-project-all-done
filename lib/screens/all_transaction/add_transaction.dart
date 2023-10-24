import 'package:flutter/material.dart';
import 'package:moneymanager/db/function/catogory/catogory_db.dart';
import 'package:moneymanager/db/function/transaction/transaction_db.dart';
import 'package:moneymanager/db/model/catogory/catogory_model.dart';
import 'package:moneymanager/db/model/transaction/transaction_model.dart';
import 'package:moneymanager/screens/app_bar/all_appbar.dart';
import 'package:moneymanager/theme/theme_constants.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String? dropdownvalue;
  DateTime _dateTime = DateTime.now();
  CatogoryType radioSelect = CatogoryType.income;
  CatogoryModel? catogoryModel;
  final _purpose = TextEditingController();
  final _amount = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool catogoryIsSelected = false;

  @override
  void initState() {
    CatogoryDb().refreshUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AllAppbar(headname: 'Add Transaction'),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Form(
                        key: _key,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      value: radioSelect,
                                      groupValue: CatogoryType.income,
                                      onChanged: (val) {
                                        setState(() {
                                          radioSelect = CatogoryType.income;
                                          dropdownvalue = null;
                                          catogoryModel = null;
                                        });
                                      },
                                    ),
                                    const Text('INCOME')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: radioSelect,
                                      groupValue: CatogoryType.expense,
                                      onChanged: (val) {
                                        setState(() {
                                          radioSelect = CatogoryType.expense;
                                          dropdownvalue = null;
                                          catogoryModel = null;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'EXPENSE',
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: radioSelect,
                                      groupValue: CatogoryType.undifined,
                                      onChanged: (val) {
                                        setState(() {
                                          radioSelect = CatogoryType.undifined;
                                          dropdownvalue = null;
                                          catogoryModel = null;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Other',
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'CATOGORY :',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 40,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 219, 219, 219),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: DropdownButton(
                                        hint: const Text('select'),
                                        value: dropdownvalue,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 17),
                                        items: radioSelect ==
                                                CatogoryType.income
                                            ? CatogoryDb()
                                                .incomeCatogoryListtner
                                                .value
                                                .map((e) {
                                                return DropdownMenuItem(
                                                  onTap: () {
                                                    catogoryModel = e;
                                                  },
                                                  value: e.id,
                                                  child: Text(e.name),
                                                );
                                              }).toList()
                                            : radioSelect ==
                                                    CatogoryType.expense
                                                ? CatogoryDb()
                                                    .expenseCatogoryListener
                                                    .value
                                                    .map((e) {
                                                    return DropdownMenuItem(
                                                      onTap: () {
                                                        catogoryModel = e;
                                                      },
                                                      value: e.id,
                                                      child: Text(e.name),
                                                    );
                                                  }).toList()
                                                : [
                                                     DropdownMenuItem(
                                                      onTap: () {
                                                        catogoryModel = CatogoryModel(id: 'undifined', name: 'undifined', type: CatogoryType.undifined , isDeleted: false);
                                                      },
                                                      value: 'undifined',
                                                      child:const Text('undifined'),
                                                    ),
                                                  ],
                                        onChanged: (val) {
                                          setState(() {
                                            dropdownvalue = val;
                                          });
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: catogoryIsSelected,
                              child: const Text(
                                'Select Catogory',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: TextFormField(
                                validator: (value) {
                                  if ((!RegExp(r'^\S+(?!\d+$)')
                                      .hasMatch(value!))) {
                                    return 'enter valid purpose';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _purpose,
                                decoration: const InputDecoration(
                                    label: Text('Purpose'),
                                    labelStyle: TextStyle(
                                        color: Color.fromARGB(112, 0, 0, 0)),
                                    filled: true,
                                    border: InputBorder.none),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: TextFormField(
                                validator: (value) {
                                  if ((!RegExp(r'^[0-9]+\.?[0-9]*$')
                                      .hasMatch(value!))) {
                                    return 'enter valid amount';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _amount,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    label: Text('Amount'),
                                    labelStyle: TextStyle(
                                        color: Color.fromARGB(112, 0, 0, 0)),
                                    filled: true,
                                    border: InputBorder.none),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () async {
                                _dateTime = (await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now()))!;
                                setState(() {});
                              },
                              icon: const Icon(Icons.calendar_month_outlined),
                              label: Text(
                                '${_dateTime.day} - ${_dateTime.month} - ${_dateTime.year}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: ElevatedButton(
                                  onPressed: () {
                                    addTransaction();
                                    TransactionDb().refreshUi();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      backgroundColor: incomeColor),
                                  child: const Text('ADD')),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    _key.currentState!.validate();
    final purposeText = _purpose.text;
    final amountText = _amount.text;
    if (catogoryModel == null) {
      catogoryIsSelected = true;
      setState(() {});
      return;
    } else {
      setState(() {
        catogoryIsSelected = false;
      });
    }
    if (purposeText.isEmpty) {
      return;
    }
    if (amountText.isEmpty || int.parse(amountText)<0) {
      return;
    }

    final parsedAmount = double.tryParse(amountText);

    if (parsedAmount == null) {
      return;
    }

    final model = TransactionModel(
      porpose: purposeText,
      amount: parsedAmount,
      dateTime: _dateTime,
      catogoryType: radioSelect,
      catogoryModel: catogoryModel!,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    TransactionDb().addTransaction(model);
    transactionAddedSnackbar(context, 'Added');
    setState(() {
      _purpose.text = '';
      _amount.text = '';
      _dateTime = DateTime.now();
      radioSelect = CatogoryType.income;
      dropdownvalue = null;
      catogoryModel = null;
      catogoryIsSelected = false;
    });
  }
}

transactionAddedSnackbar(BuildContext context, String name) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 2),
    margin: const EdgeInsets.all(20),
    behavior: SnackBarBehavior.floating,
    backgroundColor: incomeColor,
    content: Text(
      'Transaction $name',
      textAlign: TextAlign.center,
    ),
  ));
}



                           //  [
                            //   DropdownMenuItem(
                            //       onTap: () {
                            //         setState(() {
                            //           dropdownvalue = '1';
                            //         });
                            //       },
                            //       value: '1',
                            //       child: const Text('salary')),
                            //   DropdownMenuItem(
                            //       onTap: () {
                            //         setState(() {
                            //           dropdownvalue = '2';
                            //         });
                            //       },
                            //       value: '2',
                            //       child: const Text('rent')),
                            //   DropdownMenuItem(
                            //       onTap: () {
                            //         setState(() {
                            //           dropdownvalue = '3';
                            //         });
                            //       },
                            //       value: '3',
                            //       child: const Text('sales')),
                            // ],