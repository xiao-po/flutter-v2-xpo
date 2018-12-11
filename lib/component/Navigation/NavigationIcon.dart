import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationIconView{
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color
  }) :item = new BottomNavigationBarItem(
          icon: icon,
          activeIcon: activeIcon,
          title: new Text(title),
          backgroundColor: color,
        ) ;

  final BottomNavigationBarItem item;


}

class CustomInactiveIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return new Container(
        margin: const EdgeInsets.all(4.0),
        width: iconTheme.size - 8.0,
        height: iconTheme.size - 8.0,
        decoration: new BoxDecoration(
          border: new Border.all(color: iconTheme.color, width: 2.0),
        )
    );
  }
}


class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return new Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: iconTheme.color,
    );
  }
}