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
  List<VNode> nodes = <VNode>[
    new VNode("tech", "技术"),
    new VNode("creative", "创意"),
    new VNode("play", "好玩"),
    new VNode("apple", "apple"),
    new VNode("jobs", "酷工作"),
    new VNode("qna", "问与答"),
    new VNode("hot", "最热"),
    new VNode("all", "全部")
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


