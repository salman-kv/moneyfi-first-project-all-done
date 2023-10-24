import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moneymanager/db/function/transaction/transaction_db.dart';
import 'package:moneymanager/db/model/graph/graph_model.dart';
import 'package:moneymanager/theme/theme_constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

ValueNotifier<DateTime> startDateGraphListener =
    ValueNotifier(TransactionDb().startDateFilter!);
ValueNotifier<DateTime> endDateGraphListener = ValueNotifier(DateTime.now());

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  void initState() {
    startDateGraphListener.value = TransactionDb().startDateFilter!;
    endDateGraphListener.value = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        Scaffold(
          body: ValueListenableBuilder(
            valueListenable: TransactionDb().allTransactionListener,
            builder: (context, value, child) {
              return TransactionDb().allTransactionListener.value.isNotEmpty ?  SfCircularChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                title: ChartTitle(
                  text: 'Statistics',
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
                series: <CircularSeries>[
                  PieSeries<GraphModel, String>(
                    pointColorMapper: (datum, index) {
                      return index==0 ? incomeColor : index==1 ? expenseColor : const Color.fromARGB(255, 26, 68, 103);
                    },
                    dataSource: getGraphIEOnly(),
                    xValueMapper: (GraphModel datum, index) {
                      return datum.name;
                    },
                    yValueMapper: (GraphModel data, index) {
                      return data.sum;
                    },
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      borderColor: Color.fromARGB(255, 2, 42, 42),
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 249, 249, 249),
                          fontSize: 15),
                    ),
                  ),
                ],
                legend: const Legend(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    iconHeight: 15,
                    iconWidth: 15,
                    isVisible: true,
                    position: LegendPosition.left,
                    alignment: ChartAlignment.center),
              ) :  SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/pie no data.png'),
                    const Text('no data',style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(250, 0, 0, 0),
            onPressed: () {
              bottemFilterGraph(context, MediaQuery.of(context).size,
                  Theme.of(context).textTheme, 0);
            },
            child: const Icon(Icons.filter_alt),
          ),
        ),
        Scaffold(
          body: ValueListenableBuilder(
            valueListenable: TransactionDb().allTransactionListener,
            builder: (context, value, child) {
              return  TransactionDb().allTransactionListener.value.isNotEmpty ? SfCircularChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                title: ChartTitle(
                  text: 'Statistics On Catogory Base',
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
                series: <CircularSeries>[
                  PieSeries<GraphModel, String>(
                    dataSource: getGraph(),
                    xValueMapper: (GraphModel datum, index) {
                      return datum.name;
                    },
                    yValueMapper: (GraphModel data, index) {
                      return data.sum;
                    },
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      borderColor: Color.fromARGB(255, 2, 42, 42),
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 16, 16, 16),
                          fontSize: 15),
                    ),
                  ),
                ],
                legend: const Legend(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    iconHeight: 15,
                    iconWidth: 15,
                    isVisible: true,
                    position: LegendPosition.left,
                    alignment: ChartAlignment.center),
              ) : const Center(child: Text('no data',style: TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),));
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(250, 0, 0, 0),
            onPressed: () {
              bottemFilterGraph(context, MediaQuery.of(context).size,
                  Theme.of(context).textTheme, 0);
            },
            child: const Icon(Icons.filter_alt),
          ),
        ),
      ],
    );
  }

  bottemFilterGraph(
      BuildContext context, Size size, TextTheme textTheme, int selectedpage) {
    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return SizedBox(
            height: size.height / 2.5,
            child:
                const Padding(padding: EdgeInsets.all(8.0), child: DateSort()),
          );
        });
  }
}

class DateSort extends StatefulWidget {
  const DateSort({super.key});

  @override
  State<DateSort> createState() => _DateState();
}

class _DateState extends State<DateSort> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    startDate = startDateGraphListener.value;
    endDate = endDateGraphListener.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text(
                  'Start Date',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () async {
                    startDate = (await showDatePicker(
                        context: context,
                        initialDate: TransactionDb().startDateFilter!,
                        firstDate: TransactionDb().startDateFilter!,
                        lastDate:
                            endDate == null ? DateTime.now() : endDate!))!;
                    setState(() {});
                  },
                  icon: const Icon(Icons.calendar_month_outlined),
                  label: startDate == null
                      ? const Text('select')
                      : Text(
                          '${startDate?.day} - ${startDate?.month} - ${startDate?.year}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            ),
            TextButton.icon(
              onPressed: () async {
                endDate = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: startDate!,
                    lastDate: DateTime.now()))!;
                setState(() {});
              },
              icon: const Icon(Icons.calendar_month_outlined),
              label: endDate == null
                  ? const Text('select')
                  : Text(
                      '${endDate?.day} - ${endDate?.month} - ${endDate?.year}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                startDateGraphListener.value = startDate!;
                endDateGraphListener.value = endDate!;
                TransactionDb().transactionFilterOnlyDate(
                    startDateGraphListener.value, endDateGraphListener.value);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.filter_list),
              label: const Text('Filter'),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                startDateGraphListener.value = TransactionDb().startDateFilter!;
                endDateGraphListener.value = DateTime.now();
                TransactionDb().refreshUi();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
              label: const Text('Clear'),
            ),
          ],
        )
      ],
    );
  }
}
