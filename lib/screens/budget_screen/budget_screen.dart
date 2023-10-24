import 'package:circular_progress_stack/circular_progress_stack.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/db/function/catogory/catogory_db.dart';
import 'package:moneymanager/db/model/budget_model/budget_model.dart';
import 'package:moneymanager/screens/budget_screen/budget_add.dart';
import 'package:moneymanager/theme/theme_constants.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: ValueListenableBuilder(
          valueListenable: CatogoryDb().budgetValueNofifyListener,
          builder: (BuildContext, List<BudgetModel> newList, _) {
            var bu=false;
            newList.forEach((element) {
              if(element.budget!=0){
                bu=true;
              }
            });
            return  SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  bu ? Expanded(
                    child : ListView(
                      children:  List.generate(newList.length, (index)  {
                        return newList[index].budget != 0 
                            ?  FutureBuilder<double>(
                               future: CatogoryDb().budgetCalc(newList[index]),
                              builder:(context, snapshot) {
                                if(snapshot.data==null){
                                  return const SizedBox();
                                }
                                return  Column(
                                  children: [
                                    Text(
                                      newList[index].catogoryModel.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child:
                                          SingleGradientStackCircularProgressBar(
                                          size: 200,
                                          progressStrokeWidth: 25,
                                          backStrokeWidth: 25,
                                          mergeMode: true,
                                          maxValue:  newList[index].budget ,
                                          backColor:const Color.fromARGB(255, 224, 224, 224),
                                          barColores: const [
                                            Color.fromARGB(255, 151, 151, 151),
                                            Color.fromARGB(255, 61, 61, 61),
                                            Color.fromARGB(255, 38, 38, 38),
                                            Color.fromARGB(255, 0, 0, 0)
                                          ],
                                          fullProgressColor:const Color.fromARGB(255, 182, 5, 5),
                                          barValue: snapshot.data!,
                                          
                                          
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('${snapshot.data!} / ',style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color:  snapshot.data! > newList[index].budget ? const Color.fromARGB(255, 182, 5, 5) : Colors.black
                                        ),),
                                        Text('${newList[index].budget}',style: const TextStyle(
                                          color:Color.fromARGB(255, 182, 5, 5),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                        ),),
                                      ],
                                    ),

                                    Visibility(
                                      visible: snapshot.data! > newList[index].budget,
                                      child: Text(' " ${newList[index].catogoryModel.name} is out of budget " ',style: const TextStyle(
                                        color: Color.fromARGB(255, 182, 5, 5),
                                        fontSize: 17
                                      ),)),

                                    const SizedBox(height: 15,)
                                  ],
                                );
                                
                              },
                            )
                            : const SizedBox();
                      })
                          
                    )
                  ) : Expanded(child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.asset('assets/images/no budget.png')),
                        Text('No Budget',style: TextStyle(
                          color: expenseColor,
                          fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                  )),
                  Container(
                    width: size.width * .5,
                    margin:const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(100),
                      color: Colors.black
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return const BudgetAdd();
                          }));
                        },
                        child:const Text('Set Budget',style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),)),
                  )
                ],
              ),
            );
          }),
    );
  }
}
