import 'package:flutter/material.dart';
import 'package:v2_xpo/view/all-view.dart';

class ViewRoute {
  const ViewRoute({
    this.title,
    this.icon,
    this.subtitle,
    this.routeName,
    this.buildRoute,
  }) : assert(title != null),
        assert(routeName != null),
        assert(buildRoute != null);

  final String title;
  final IconData icon;
  final String subtitle;
  final String routeName;
  final WidgetBuilder buildRoute;

  @override
  String toString() {
    return '$runtimeType($title $routeName)';
  }
}

List<ViewRoute> _allViewRoutes() {
  return <ViewRoute>[
    ViewRoute(
      title: IndexPage.title,
      routeName: IndexPage.routeName,
      buildRoute: (BuildContext context) => IndexPage(),
    ),
    ViewRoute(
      title: ReplyPage.title,
      routeName: ReplyPage.routeName,
      buildRoute: (BuildContext context) => ReplyPage(),
    )
  ];
}


final List<ViewRoute> allViewRoutes = _allViewRoutes();
