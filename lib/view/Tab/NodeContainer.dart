import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v2_xpo/model/Node.dart';
import 'package:v2_xpo/service/indexService.dart';
import 'package:v2_xpo/service/userService.dart';
import 'package:v2_xpo/view/Tab/TopicCard.dart';

class NodeContainer extends StatefulWidget {
  VNode node;
  NodeContainer({this.node}):super();
  List<Topic> topics = <Topic>[];
  @override
  _NodeContainerState createState() => _NodeContainerState(node: node);
}

class _NodeContainerState extends State<NodeContainer>
    with AutomaticKeepAliveClientMixin{
  VNode node ;
  List<Topic> topics = <Topic>[];
  _NodeContainerState({this.node});
  UserService userService = new UserService();


  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xcccccc),
      body: _buildRefreshTab(),
    );
  }

  List<Widget> _buildList(List<Topic> topics) {
    List<Widget> list = <Widget>[];
    for (Topic topic in topics) {
       list.add(new TopicCard(topic: topic,));
    }
    return list;
  }

  Widget _buildRefreshTab() {
     return new RefreshIndicator(
       child: _buildTab(),
       onRefresh: _refresh,
     );
  }

  Widget _buildTab(){
    if (topics.length > 0) {
      return  new ListView(
        scrollDirection: Axis.vertical,

        children: _buildList(topics),
      );
    }
    return new Center(
        child: new CircularProgressIndicator()
    );

  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _refresh() async {
    topics = await IndexService.getIndexHtmlData(node);
    print("over");
    if (!mounted) return;
    setState(() {
    });
  }
}


