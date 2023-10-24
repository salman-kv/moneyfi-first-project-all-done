import 'package:flutter/material.dart';
import 'package:moneymanager/screens/app_bar/all_appbar.dart';
import 'package:moneymanager/theme/theme_constants.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:const  AllAppbar(headname: 'Edit Profile'),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                decoration: const InputDecoration(
                    label: Text('Name'),
                    labelStyle: TextStyle(color: Color.fromARGB(112, 0, 0, 0)),
                    filled: true,
                    border: InputBorder.none),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor: incomeColor),
                  child: const Text('Update')),
            ),
          ],
        ),
      ),
    );
  }
}
