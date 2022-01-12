import 'package:flutter/material.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/shared/styles.dart';

class MessageAppBar extends StatelessWidget implements PreferredSizeWidget {
  // variables
  final String title;
  final bool centerTitle;
  final Map<String, dynamic> menuItems;

  // constructor
  const MessageAppBar({
    required this.title,
    this.centerTitle = true,
    required this.menuItems,
    Key? key,
  }) : super(key: key);

  // overrides
  @override
  Widget build(BuildContext context) => AppBar(
        iconTheme: const IconThemeData(color: Constants.primaryColorDark),
        backgroundColor: Constants.primaryColor,
        title: barTitle(),
        centerTitle: centerTitle,
        actions: [menu()],
        actionsIconTheme:
            const IconThemeData(color: Constants.secondaryColorDark),
      );

  @override
  Size get preferredSize => const Size.fromHeight(56);

  // private functions
  Widget barTitle() => Text(
        title,
        style: Styles.appBarTextStyle(),
      );

  PopupMenuButton<String> menu() => PopupMenuButton<String>(
        itemBuilder: (BuildContext context) => menuItems.keys
            .map((String choice) => PopupMenuItem<String>(
                  value: choice,
                  textStyle: Styles.basicTextStyle(),
                  child: Text(choice),
                ))
            .toList(),
        onSelected: (choice) => menuItems[choice](),
      );
}
