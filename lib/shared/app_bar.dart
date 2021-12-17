import 'package:flutter/material.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/shared/styles.dart';

class MessageAppBar extends StatelessWidget implements PreferredSizeWidget {
  // variables
  final String title;
  final Map<String, dynamic> menuItems;

  // constructor
  const MessageAppBar(this.title, this.menuItems, {Key? key}) : super(key: key);

  // overrides
  @override
  Widget build(BuildContext context) => AppBar(
        backgroundColor: Constants.primaryColor,
        title: barTitle(),
        actions: [menu()],
        actionsIconTheme: const IconThemeData(color: Constants.secondaryColor),
      );

  @override
  Size get preferredSize => const Size.fromHeight(56);

  // private functions
  Text barTitle() => Text(title, style: Styles.appBarTextStyle());

  PopupMenuButton<String> menu() => PopupMenuButton<String>(
        itemBuilder: (BuildContext context) => menuItems.keys
            .map((String choice) => PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                ))
            .toList(),
        onSelected: (choice) => menuItems[choice](),
      );
}
