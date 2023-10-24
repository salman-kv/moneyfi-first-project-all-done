import 'package:flutter/material.dart';
import 'package:moneymanager/db/function/clear_all/clear_all.dart';
import 'package:moneymanager/screens/all_transaction/deleted_screen.dart';
import 'package:moneymanager/screens/privacy_policy_faq/faq.dart';
import 'package:moneymanager/screens/privacy_policy_faq/privacy_screen.dart';
import 'package:moneymanager/screens/privacy_policy_faq/terms&condition.dart';
import 'package:moneymanager/theme/theme_constants.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://www.instagram.com/_salman_kv_/');

class DrawerPage extends StatelessWidget {
  final TextTheme texTheme;
  const DrawerPage({required this.texTheme, super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(15), bottomRight: Radius.circular(10)),
      child: Drawer(
        backgroundColor:const Color.fromARGB(240,255, 247, 241),
        width: size.width * .65,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Menu',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Color.fromARGB(255, 12, 12, 12),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return const DeletedScreen();
                    }));
                    // Scaffold.of(context).closeDrawer();
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Deleted Transactions',
                      style: texTheme.titleLarge
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    launchUrl(_url);
                    // Navigator.of(context).pop();
                    Scaffold.of(context).closeDrawer();
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'About us',
                      style: texTheme.titleLarge
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return const FaqScreen();
                    }));
                    // Navigator.of(context).pop();
                    Scaffold.of(context).closeDrawer();
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Faq',
                      style: texTheme.titleLarge
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return const PrivacyScreen();
                    }));
                    // Navigator.of(context).pop();
                    Scaffold.of(context).closeDrawer();
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Privacy policy',
                      style: texTheme.titleLarge
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return const TermsAndCondition();
                    }));
                    // Navigator.of(context).pop();
                    Scaffold.of(context).closeDrawer();
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Terms & Condition',
                      style: texTheme.titleLarge
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigator.of(context).pop();
                    clearAllDialog(context);
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Clear All',
                          style: texTheme.titleLarge?.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 76, 35, 35)),
                        ),
                        const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 76, 35, 35),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> clearAllDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 238, 237, 235),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const Column(
              children: [
                Icon(
                  Icons.warning,
                  color: Color.fromARGB(255, 244, 67, 54),
                  size: 29,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Do you want to clear all data from the application ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )),
              TextButton(
                  onPressed: () {
                    clearAll(context);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )),
            ],
          );
        });
  }
}
