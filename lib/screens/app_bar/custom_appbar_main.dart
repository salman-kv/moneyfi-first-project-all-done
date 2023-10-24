import 'package:flutter/material.dart';
import 'package:moneymanager/theme/theme_constants.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final headname;
   CustomAppbar({this.headname,super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    // TextTheme _textTheme=Theme.of(context).textTheme;
    return ColoredBox(
      color: Colors.black,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: mainColor),
          color:mainColor,
          borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
        ),
        width: double.infinity,
        height: 50,
        child: Stack(
          children: [
            IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.sort,
                  size: 35,
                )),
           
          ],
        ),
    
        // child: IconButton(onPressed: (){
        //   Scaffold.of(context).openDrawer();
        // }, icon: Icon(Icons.abc)),
      ),
    );
  }
}
