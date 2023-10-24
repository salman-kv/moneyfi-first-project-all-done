
import 'package:flutter/material.dart';
import 'package:moneymanager/db/function/catogory/catogory_db.dart';
import 'package:moneymanager/db/function/transaction/transaction_db.dart';
import 'package:moneymanager/screens/all_transaction/transaction.dart';
import 'package:moneymanager/theme/theme_constants.dart';

class Search extends StatelessWidget {
   Search({super.key});
  final searchText=TextEditingController();
  // final ValueNotifier<String> search=ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField( 
              onChanged: (value) {
                selectListener.value=0;
                if(value.isEmpty){
              CatogoryDb().refreshUi();
              TransactionDb().refreshUi();
                }
                else{
                   CatogoryDb().seearchRefresh(searchText.text);
                   TransactionDb().serarchrefreshUi(searchText.text);
                }           
              },
              controller: searchText,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: Color.fromARGB(255, 19, 6, 121))),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: const BorderSide(color: Color.fromARGB(255, 255, 255, 255))),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(105, 0, 0, 0), fontSize: 16),
                  prefixIcon:const Icon(Icons.search),
                  suffixIcon:  IconButton(onPressed: (){
                    searchText.text='';
                       TransactionDb().refreshUi();
                  }, icon: const Icon(Icons.close)), 
                  suffixIconColor: expenseColor),
            ),
          ),
        ],
      ),
    );
  }
}
