import 'package:flutter/material.dart';
import 'package:moneymanager/db/function/catogory/catogory_db.dart';
import 'package:moneymanager/db/function/transaction/transaction_db.dart';
import 'package:moneymanager/screens/all_transaction/transaction.dart';
import 'package:recase/recase.dart';

class TransactionFilter extends StatefulWidget {
  final int selectedpage;
  const TransactionFilter({required this.selectedpage,super.key});

  @override
  State<TransactionFilter> createState() => _TransactionFilterState();
}

class _TransactionFilterState extends State<TransactionFilter> {
  DateTime? startDate;
  DateTime? endDate;

  List<bool> allCatogoryStatus = [];
  int? _transactionFilterSelectedCatogoryIndex;
  String? catogoryName;

  @override
  void initState() {
    startDate = transactionFilterStartDate.value;
    endDate =transactionFilterEndDate.value; 
    allCatogoryStatus.clear();
    _transactionFilterSelectedCatogoryIndex =
        transactionFilterSelectedCatogoryIndex.value;
    catogoryName = transactionFilterSelectedCatogory.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filter By ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Select Date : ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                const Text(
                  'Start : ',
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 228, 227, 225)
                  ),
                  child: TextButton.icon(
                    onPressed: () async {
                      startDate = (await showDatePicker(
                          context: context,
                          initialDate: TransactionDb().startDateFilter!,
                          firstDate: TransactionDb().startDateFilter!,
                          lastDate: endDate==null ? DateTime.now() : endDate!))!;
                      setState(() {});
                    },
                    icon: const Icon(Icons.date_range),
                    label: Text(
                      '${startDate!.year} - ${startDate!.month} - ${startDate!.day}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 32, 69, 99),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'End : ',
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 228, 227, 225)
                  ),
                  child: TextButton.icon(
                    onPressed: () async {
                      endDate = (await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: startDate!,
                          lastDate: DateTime.now()))!;
                      setState(() {});
                    },
                    icon: const Icon(Icons.date_range),
                    label: Text(
                      '${endDate!.year} - ${endDate!.month} - ${endDate!.day}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 32, 69, 99),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10,),
        const Text(
          'Select catogory : ',
          style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: ValueListenableBuilder(
            valueListenable: widget.selectedpage==0 ? CatogoryDb().toatalCatogoryListener : widget.selectedpage==1 ? CatogoryDb().incomeCatogoryListtner : CatogoryDb().expenseCatogoryListener,
            builder: (context, value, child) {
              return Wrap(
                // crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                runSpacing: 5,
                spacing: 5,
                children: List.generate(value.length, (index) {
                  if (allCatogoryStatus.length < value.length) {
                    if (_transactionFilterSelectedCatogoryIndex == index) {
                      allCatogoryStatus.add(true);
                    } else {
                      allCatogoryStatus.add(false);
                    }
                  }
                  return ChoiceChip(
                    padding:const EdgeInsets.all(10),
                    labelStyle: TextStyle(
                        color: allCatogoryStatus[index] == true
                            ? const Color.fromARGB(255, 255, 255, 255)
                            : Colors.black,
                        fontSize: 14),
                    onSelected: (val) {
                      // _transactionFilterSelectedCatogory = value[index].name;
                      catogoryName = value[index].name;
                      setState(() {
                        for (var i = 0; i < value.length; i++) {
                          if (allCatogoryStatus[i] == true) {
                            allCatogoryStatus[i] = false;
                          }
                        }
                        // print(catogoryName);
                        // print('++++++$_transactionFilterSelectedCatogoryIndex+++++++++++++++++$index');
                        if (_transactionFilterSelectedCatogoryIndex == index) {
                          // print('++++++++++++++++++');
                          // print(index);
                          catogoryName = '';
                          _transactionFilterSelectedCatogoryIndex = -1;
                          // print(catogoryName);
                          // print(_transactionFilterSelectedCatogoryIndex);
                        } else {
                          allCatogoryStatus[index] = val;
                          catogoryName = value[index].name;
                          _transactionFilterSelectedCatogoryIndex = index;
                        }
                      });
                    },
                    label: Text(value[index].name.titleCase),
                    selected: allCatogoryStatus[index],
                    backgroundColor: Color.fromARGB(255, 233, 232, 232),
                    selectedColor: const Color.fromARGB(255, 7, 7, 7),
                  );
                }),
              );
            },
          ),
        )),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                  selectListener.value=0;
                  selectListener.notifyListeners();
                transactionFilterEndDate.value = endDate!;
                transactionFilterStartDate.value = startDate!;
                transactionFilterSelectedCatogoryIndex.value =
                    _transactionFilterSelectedCatogoryIndex!;
                catogoryName == null
                    ? transactionFilterSelectedCatogory.value = ''
                    : transactionFilterSelectedCatogory.value = catogoryName!;

                if(transactionFilterSelectedCatogory.value.isEmpty){
                  TransactionDb().transactionFilterOnlyDate(startDate!, endDate!);
                }
                else{
                  TransactionDb().transactionFilterWithCatogory(startDate!, endDate!, transactionFilterSelectedCatogory.value);
                }
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.filter_list),
              label: const Text('Filter')),
        )
      ],
    );
  }
}
