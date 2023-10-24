import 'package:flutter/material.dart';
import 'package:moneymanager/db/function/catogory/catogory_db.dart';
import 'package:moneymanager/db/model/catogory/catogory_model.dart';
import 'package:moneymanager/screens/catogory/catogory_income.dart';
import 'package:moneymanager/screens/catogory/edit_catogory.dart';
import 'package:recase/recase.dart';

class CatogoryCard extends StatelessWidget {
  final TextTheme textTheme;
  final CatogoryModel singleList;
  const CatogoryCard({required this.textTheme,required this.singleList, super.key});

  @override
  Widget build(BuildContext context) { 
    var _textTheme = textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: const DecorationImage(image: AssetImage('assets/images/grid.png'),fit: BoxFit.cover)
        ),
        // height: 70,
        child: Row(
          children: [
            Expanded(
              child: Text(singleList.name.titleCase, style: _textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600
              )),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                  return EditCatogory(catogoryModel: singleList);
                }));
              },
              icon: const Icon(Icons.edit,color: Colors.white,),
            ),
            IconButton(
              onPressed: () {
                deleteAlartOnCatogory(context,singleList);
              },
              icon: const Icon(Icons.delete,color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
  Future<void> deleteAlartOnCatogory(BuildContext context,CatogoryModel catogoryModel) {
  return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 238, 237, 235),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          title: Column(
            children: [
              const Icon(Icons.warning,color: Color.fromARGB(255, 244, 67, 54),size: 29,),
              const SizedBox(height: 15,),
              Text('Do you want to delete " ${catogoryModel.name} "',textAlign: TextAlign.center,style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
              const SizedBox(height: 5,),
              const Text('All the transaction related to this catogory will move to " undifined "',textAlign: TextAlign.center,style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),)
            ],
          ),
          actions:  [
            IconButton(onPressed: (){
              Navigator.of(context).pop();
            }, icon: const Icon(
              Icons.close,
              color: Colors.red,
              size: 29,
            ),),
            IconButton(onPressed: () {

              CatogoryDb().delteCatogory(catogoryModel);
              Navigator.of(context).pop();
              catogoryDeleteSnackBar(context,'Catogory');
            }, icon:const Icon(
              Icons.check,
              color: Colors.green,
               size: 29,
            )),
            
           
          ],
        );
      });
}
}
