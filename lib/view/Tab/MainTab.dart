import 'package:flutter/material.dart';
import 'package:v2_xpo/model/Node.dart';
import 'package:v2_xpo/view/Tab/NodeContainer.dart';
class MainTab extends StatefulWidget{
  const MainTab():super();

  @override
  _MainTabState createState() => _MainTabState();

}

class _MainTabState extends State<MainTab>
  {
  String title = 'V2ex';
  List<Node> nodes = <Node>[
    new Node("index","主页"),
    new Node("tech", "技术"),
    new Node("create", "创造")
  ];

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: nodes.length,
        child: new Scaffold(
          appBar: new AppBar(

            title: new Center(
              child: new TabBar(isScrollable: true,tabs: nodes.map((node) => new Tab(text: node.name)).toList()),
            ),
          ),
          body: new TabBarView(children: nodes.map((node)=> new NodeContainer(node: node)).toList()),
        )
    );
  }
}


