import 'package:flutter/material.dart';
import 'package:moneymanager/db/function/catogory/catogory_db.dart';
import 'package:moneymanager/db/model/catogory/catogory_model.dart';
import 'package:moneymanager/screens/app_bar/all_appbar.dart';
import 'package:moneymanager/screens/catogory/catogory_income.dart';
import 'package:moneymanager/theme/theme_constants.dart';

class EditCatogory extends StatelessWidget {
  final CatogoryModel catogoryModel;
  EditCatogory({super.key, required this.catogoryModel,});
  // final _purpose = TextEditingController();
  final _key=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   var _purpose = TextEditingController(text: catogoryModel.name);
    return SafeArea(
      child: Scaffold(
        appBar: const AllAppbar(headname: 'EDIT CATOGORY'),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Form(
                  key: _key,
                  child: TextFormField(
                    controller: _purpose,
                    validator: (value) {
                      if((!RegExp(r'^\S+(?!\d+$)').hasMatch(value!)) ){
                        return 'enter valid catogory';
                      }
                      else{
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        label: Text('Purpose'),
                        labelStyle: TextStyle(color: Color.fromARGB(112, 0, 0, 0)),
                        filled: true,
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                  onPressed: () {
                    if(_key.currentState!.validate()){
                      CatogoryDb().editCatogory(CatogoryModel(
                      id: catogoryModel.id,
                      name: _purpose.text,
                      type: catogoryModel.type,
                      isDeleted: false,
                    ));
                       Navigator.of(context).pop();
                       catogoryEditSnackBar(context);
                    }
                    else{
                      print('not');
                    }
                    
                 
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor: incomeColor),
                  child: const Text('UPDATE')),
            ),
          ],
        ),
      ),
    );
  }
}
