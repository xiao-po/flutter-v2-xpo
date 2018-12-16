import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v2_xpo/component/Navigation/NavigationIcon.dart';
import 'package:v2_xpo/view/index/IndexPage.dart';

class BottomNavigation extends StatelessWidget {
  static const String routeName = '/material/bottom_navigation';
  static List<NavigationIconView> navigationViews;
  IndexPageState state;
  ValueChanged<int> onTap;

  BottomNavigation({IndexPageState state,ValueChanged<int> onTap}){
    this.onTap = onTap;
    this.state = state;
    navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.access_alarm),
        title: 'Alarm',
        color: Colors.deepPurple
      ),
      new NavigationIconView(
        activeIcon: new CustomIcon(),
        icon: new CustomInactiveIcon(),
        title: 'Box',
        color: Colors.deepOrange,
      ),
      new NavigationIconView(
        activeIcon: const Icon(Icons.access_alarm),
        icon: const Icon(Icons.cloud_queue),
        title: 'Cloud',
        color: Colors.teal,
      ),
      new NavigationIconView(
        activeIcon: const Icon(Icons.favorite),
        icon: const Icon(Icons.favorite_border),
        title: 'Favorites',
        color: Colors.indigo,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.event_available),
        title: 'Event',
        color: Colors.pink,
      )
    ];
  }




  @override
  Widget build(BuildContext context) {
    return new BottomNavigationBar (
      items: navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: this.state.currentIndex,
      type: this.state.type,
      onTap: this.onTap
    );
  }
}

