import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanager/db/model/target/target_model.dart';
import 'package:moneymanager/screens/app_bar/all_appbar.dart';
import 'package:moneymanager/theme/theme_constants.dart';

ValueNotifier<TargetModelOfMoney> targetModelListener = ValueNotifier(
    TargetModelOfMoney(
        target: 'Add Target',
        startTime: DateTime.now(),
        endTime: DateTime.now()));

class AddTarget extends StatefulWidget {
  const AddTarget({super.key});

  @override
  State<AddTarget> createState() => _AddTargetState();
}

class _AddTargetState extends State<AddTarget> {
  DateTime? _startDate;
  DateTime? _endDate;
  TextEditingController _target = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    var val = targetModelListener.value;
    _startDate = val.startTime;
    _endDate = val.endTime;
    _target.text = val.target;
    refreshTarget();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      appBar: const AllAppbar(
        headname: 'TARGET',
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Form(
                  key: _formkey,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      validator: (value) {
                        print(value);
                        if ((!RegExp(r'^\S+(?!\d+$)').hasMatch(value!)) ||
                            value == 'Add Target') {
                          return 'enter valid Target';
                        } else {
                          return null;
                        }
                      },
                      controller: _target,
                      decoration: const InputDecoration(
                          label: Text('Target'),
                          labelStyle:
                              TextStyle(color: Color.fromARGB(112, 0, 0, 0)),
                          filled: true,
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Starting Date : ',
                      style: _textTheme.titleMedium,
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        _startDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3000));
                        setState(() {});
                      },
                      icon: const Icon(Icons.calendar_month_outlined),
                      label: _startDate == null
                          ? const Text('select starting date')
                          : Text(
                              '${_startDate?.day} - ${_startDate?.month} - ${_startDate?.year}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ending Date : ',
                      style: _textTheme.titleMedium,
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        _endDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3000));
                        setState(() {});
                      },
                      icon: const Icon(Icons.calendar_month_outlined),
                      label: _endDate == null
                          ? const Text('select starting date')
                          : Text(
                              '${_endDate?.day} - ${_endDate?.month} - ${_endDate?.year}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                if(_startDate!.isAfter(_endDate!)){
                                  targetSnackbar('invalid Date', const Color.fromARGB(255, 163, 17, 7));
                                  return;
                                }
                                if (_target.text.isEmpty) {
                                  return;
                                }
                                addTarget(TargetModelOfMoney(
                                    target: _target.text,
                                    startTime: _startDate!,
                                    endTime: _endDate!));
                                Navigator.of(context).pop();
                                targetSnackbar('Target Updated', Color.fromARGB(255, 5, 107, 9));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                backgroundColor: incomeColor),
                            child: const Text('ADD')),
                      ),
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 162, 13, 2),
                        ),
                        onPressed: () {
                          showDialog(context: context, builder: (ctx){
                            return  AlertDialog(
                              content: Text('Do you want to remove your target'),
                              actions: [
                                IconButton(onPressed: (){
                                  Navigator.of(context).pop();

                                }, icon: Icon(Icons.close)),
                                IconButton(onPressed: (){
                                  
                          targetModelListener.value = TargetModelOfMoney(
                              target: 'Add Target',
                              startTime: DateTime.now(),
                              endTime: DateTime.now());
                          Navigator.of(context).pop();

                          Navigator.of(context).pop();
                                }, icon: Icon(Icons.check)),
                                
                              ],
                             );

                          });
                         

                        },
                        icon: Icon(Icons.close),
                        label: Text('Clear'))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  targetSnackbar(String data,Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(data),
        backgroundColor:color,
        margin: EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> addTarget(TargetModelOfMoney targetModel) async {
    var box = await Hive.openBox<TargetModelOfMoney>('Target-Db');
    await box.put('Target', targetModel);
    // var left=await targetModel.startTime.difference(targetModel.endTime);
    // print(left);
    refreshTarget();
  }
}
  Future<void> refreshTarget() async {
    var box = await Hive.openBox<TargetModelOfMoney>('Target-Db');
    var val = await box.get('Target');
    targetModelListener.value = val!;
    targetModelListener.notifyListeners();
  }