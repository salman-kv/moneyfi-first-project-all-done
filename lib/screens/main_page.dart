import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moneymanager/db/function/transaction/transaction_db.dart';
import 'package:moneymanager/screens/budget_screen/budget_screen.dart';
import 'package:moneymanager/screens/all_transaction/transaction.dart';
import 'package:moneymanager/screens/app_bar/custom_appbar_main.dart';
import 'package:moneymanager/screens/catogory/catogory_income.dart';
import 'package:moneymanager/screens/drawer/drawer_page.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:moneymanager/screens/graph/graph_screen.dart';
import 'package:moneymanager/screens/home_screen/home_page.dart';
import 'package:moneymanager/theme/theme_constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int val = 0;
  final pages = const [
    HomePage(),
    AllTransactionScreen(),
    GraphScreen(),
    CatogoryIncome(),
    BudgetScreen()
  ];

  @override
  void initState() {    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppbar(),
          drawer: DrawerPage(
            texTheme: Theme.of(context).textTheme,
          ),
          body: pages[val],
          bottomNavigationBar:
NavigationBar(
            // surfaceTintColor: Colors.amber,

            // backgroundColor: Colors.black,
            selectedIndex: val,
            destinations:const [
              NavigationDestination(
                
                icon: Icon(
                  Icons.home,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 30,
                ),
                label: 'Home',
                
              ),
              NavigationDestination(
                icon: FaIcon(
                  FontAwesomeIcons.moneyCheckDollar,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                label: 'Transaction',
              ),
              NavigationDestination(
                icon: FaIcon(
                  FontAwesomeIcons.chartPie,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                label: 'Graph',
              ),
              NavigationDestination(
                icon:
                    Icon(Icons.grid_view_sharp, color: Color.fromARGB(255, 0, 0, 0), size: 30),
                label: 'Catogory',
              ),
              NavigationDestination(
                icon: Icon(Icons.attach_money_outlined,
                    color: Color.fromARGB(255, 0, 0, 0), size: 30),
                label: 'Budget',
              ),
            ],
            onDestinationSelected: (value) {
              setState(() {
                
              });
              val=value;
            },
            
          ),
 
          
          ),
    );
  }
}



//  CurvedNavigationBar(
//           index: val,
//           animationCurve: Curves.decelerate,
//           backgroundColor: mainColor ,
//           color: const Color.fromARGB(255, 0, 0, 0),
//           animationDuration: const Duration(milliseconds: 500),
//           items: const [
//             CurvedNavigationBarItem(
//                 child: Icon(
//                   Icons.home,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//                 label: 'Home',
//                 labelStyle: TextStyle(color: Colors.white)),  
//             CurvedNavigationBarItem(
//                 child: FaIcon(
//                   FontAwesomeIcons.moneyCheckDollar,
//                   color: Colors.white,
//                 ),
//                 label: 'Transaction',
//                 labelStyle: TextStyle(color: Colors.white)),

//             CurvedNavigationBarItem(
//                 child: FaIcon(
//                   FontAwesomeIcons.chartPie,
//                   color: Colors.white,
//                 ),
//                 label: 'Graph',
//                 labelStyle: TextStyle(color: Colors.white)),
//             CurvedNavigationBarItem(
//                 child:
//                     Icon(Icons.grid_view_sharp, color: Colors.white, size: 30),
//                 label: 'Catogory',
//                 labelStyle: TextStyle(color: Colors.white)),

//             CurvedNavigationBarItem(
//                 child: Icon(Icons.attach_money_outlined, color: Colors.white, size: 30),
//                 label: 'Budget',
//                 labelStyle: TextStyle(color: Colors.white)),
//           ],
//           onTap: (index) {
//             setState(() {
//               val = index;
//             });
//           },
//         ),


// NavigationBar(
//             // surfaceTintColor: Colors.amber,

//             // backgroundColor: Colors.black,
//             selectedIndex: val,
//             destinations:const [
//               NavigationDestination(
                
//                 icon: Icon(
//                   Icons.home,
//                   color: Color.fromARGB(255, 0, 0, 0),
//                   size: 30,
//                 ),
//                 label: 'Home',
                
//               ),
//               NavigationDestination(
//                 icon: FaIcon(
//                   FontAwesomeIcons.moneyCheckDollar,
//                   color: Color.fromARGB(255, 0, 0, 0),
//                 ),
//                 label: 'Transaction',
//               ),
//               NavigationDestination(
//                 icon: FaIcon(
//                   FontAwesomeIcons.chartPie,
//                   color: Color.fromARGB(255, 0, 0, 0),
//                 ),
//                 label: 'Graph',
//               ),
//               NavigationDestination(
//                 icon:
//                     Icon(Icons.grid_view_sharp, color: Color.fromARGB(255, 0, 0, 0), size: 30),
//                 label: 'Catogory',
//               ),
//               NavigationDestination(
//                 icon: Icon(Icons.attach_money_outlined,
//                     color: Color.fromARGB(255, 0, 0, 0), size: 30),
//                 label: 'Budget',
//               ),
//             ],
//             onDestinationSelected: (value) {
//               setState(() {
                
//               });
//               val=value;
//             },
            
//           ),