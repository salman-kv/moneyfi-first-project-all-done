
import 'package:flutter/material.dart';
import 'package:moneymanager/db/function/transaction/transaction_db.dart';
import 'package:moneymanager/screens/all_transaction/transaction.dart';

class TransactionSort extends StatefulWidget {
  final selectedListener;
  const TransactionSort({required this.selectedListener, super.key});

  @override
  State<TransactionSort> createState() => _FilterState();
}

class _FilterState extends State<TransactionSort> {
  int? selectedFilterRadio;

  @override
  void initState() {
    selectedFilterRadio = widget.selectedListener;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var textsize = MediaQuery.of(context).textScaleFactor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
         const Text(
          'Sort By : ',
          style: TextStyle(
              color: Colors.black, fontSize: 21, fontWeight: FontWeight.bold),
                 ),
        Row(
          children: [
            Radio(
              value: 0,
              groupValue: selectedFilterRadio,
              onChanged: (val) {
                setState(() {
                  selectedFilterRadio = val!;
                  // selectListener.value = val;
                });
              },
              fillColor: MaterialStateProperty.all(const Color.fromARGB(255, 0, 0, 0)),
            ),
          const  Text(
              'Non',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              value: 1,
              groupValue: selectedFilterRadio,
              onChanged: (val) {
                setState(() {
                  selectedFilterRadio = val!;
                  // selectListener.value = val;
                });
              },
              fillColor: MaterialStateProperty.all(const Color.fromARGB(255, 0, 0, 0)),
            ),
            const Text(
              'Amount (high to low)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              value: 2,
              groupValue: selectedFilterRadio,
              onChanged: (val) {
                setState(() {
                  selectedFilterRadio = val!;
                  // selectListener.value = val;
                });
              },
              fillColor: MaterialStateProperty.all(const Color.fromARGB(255, 0, 0, 0)),
            ),
          const  Text(
              'Amount ( low to high )',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              value: 3,
              groupValue: selectedFilterRadio,
              onChanged: (val) {
                setState(() {
                  selectedFilterRadio = val!;
                  // selectListener.value = val;
                });
              },
              fillColor: MaterialStateProperty.all(const Color.fromARGB(255, 0, 0, 0)),
            ),
            const Text(
              'Date ( last to first )',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              value: 4,
              groupValue: selectedFilterRadio,
              onChanged: (val) {
                setState(() {
                  selectedFilterRadio = val!;
                  // selectListener.value = val;
                });
              },
              fillColor: MaterialStateProperty.all(const Color.fromARGB(255, 0, 0, 0)),
            ),
            const Text(
              'Date ( first to last )',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 40),
                    maximumSize: Size(150, 40),
                    backgroundColor: Colors.black),
                onPressed: () {
                  filterCheck();
                  selectListener.value = selectedFilterRadio!;
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Sort',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        )
      ],
    );
  }

  Future<void> filterCheck() async {
    await TransactionDb().filterRefresh(selectedFilterRadio!);
  }
}