import 'dart:core';

import 'package:flutter/material.dart';
import 'package:moneymanager/db/function/catogory/catogory_db.dart';
import 'package:moneymanager/db/model/catogory/catogory_model.dart';
import 'package:moneymanager/screens/app_bar/all_appbar.dart';
import 'package:moneymanager/theme/theme_constants.dart';

class AddCatogory extends StatelessWidget {
  final CatogoryType type;
  AddCatogory({super.key, required this.type});
  final _purpose = TextEditingController();
  final _key=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AllAppbar(headname: 'ADD CATOGORY'),
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
                      CatogoryDb().insertCatogory(CatogoryModel(
                      id: DateTime.now().microsecondsSinceEpoch.toString(),
                      name: _purpose.text,
                      type: type,
                      isDeleted: false,
                    ));
                       Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor: incomeColor),
                  child: const Text('ADD')),
            ),
          ],
        ),
        // floatingActionButton: Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     FloatingActionButton(onPressed: (){}),
        //     FloatingActionButton(onPressed: (){}),
        //   ],
        // ),
      ),
    );
  }
}
