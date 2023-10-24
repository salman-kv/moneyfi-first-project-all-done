
import 'package:flutter/material.dart';
import 'package:moneymanager/db/function/catogory/catogory_db.dart';
import 'package:moneymanager/db/model/budget_model/budget_model.dart';
import 'package:moneymanager/screens/app_bar/all_appbar.dart';

class BudgetAmountSetting extends StatelessWidget {
 final BudgetModel budgetModel;
   BudgetAmountSetting({required this.budgetModel,super.key});
TextEditingController budgetField=TextEditingController();
var _key=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    budgetModel.budget!=0 ? budgetField.text=budgetModel.budget.toString() : budgetField.text=''; 
    return SafeArea(child: Scaffold(
      appBar:const AllAppbar(
        headname: 'Set Budget',
      ),
      body:Column(children: [
        Text(budgetModel.catogoryModel.name,style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _key,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: budgetField,
              validator: (value) {
                                    if ((!RegExp(r'^[0-9]+\.?[0-9]*$')
                                        .hasMatch(value!))) {
                                      return 'enter valid amount';
                                    } else {
                                      return null;
                                    }
                                  },
              decoration: InputDecoration(
                labelText:'budget',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100)
                )
              ),
             ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)
            ),
            backgroundColor: Colors.black,
          ),
          onPressed: () async{
            if(_key.currentState!.validate()){
 Navigator.of(context).pop();
           budgetModel.budget=double.tryParse(budgetField.text)!; 
           budgetModel.selected=true;
           CatogoryDb().budgetSet(budgetModel);
            }
          
        }, child: Icon(Icons.check)),
       
      ]),
    ));
  }
}