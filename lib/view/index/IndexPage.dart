import 'package:flutter/material.dart';
import 'package:v2_xpo/model/title.dart';
import 'package:v2_xpo/component/Navigation/BottomNavigation.dart';
import 'package:v2_xpo/view/Tab/MainTab.dart';

final List<MyTitle> titles = <MyTitle>[
  new MyTitle(name:"技术", eName: "tech"),
  new MyTitle(name:"创意", eName: "creative"),
];

class IndexPage extends StatefulWidget  {
  static const String routeName = '/';
  static const String title = '主页';
  IndexPage({Key key}) : super(key: key);


  @override
  IndexPageState createState() => new IndexPageState();
}
class IndexPageState extends State<IndexPage> with TickerProviderStateMixin  {
  int currentIndex = 0;
  BottomNavigationBarType type = BottomNavigationBarType.fixed;

  rebuild() {
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    BottomNavigation bottomNavigation = new BottomNavigation(
        state: this,
        onTap: (int index){
          setState(() {
            currentIndex = index;
          });
        });
    return new Scaffold(
            body: _generatorTab() ,  // 主页
            bottomNavigationBar: bottomNavigation, // 底部导航栏
        );
  }

  Widget _generatorTab() {
    List<Widget> tabs = <Widget>[
      new MainTab(),
      new Center(
        child: new Text("1"),
      ),
      new Center(
        child: new Text("2"),
      ),
      new Center(
        child: new Text("3"),
      ),
      new Center(
        child: new Text("4"),
      ),
    ];
    return tabs[currentIndex];
  }
}