import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v2_xpo/model/model.dart';
import 'package:v2_xpo/service/indexService.dart';
import 'package:v2_xpo/service/userService.dart';
import 'package:v2_xpo/view/Tab/TopicCard.dart';

class NodeContainer extends StatefulWidget {
  VNode node;
  NodeContainer({this.node}):super();
  List<TopicListItem> topics = <TopicListItem>[];
  @override
  _NodeContainerState createState() => _NodeContainerState(node: node);
}

class _NodeContainerState extends State<NodeContainer>
    with AutomaticKeepAliveClientMixin {
  VNode node ;
  List<TopicListItem> topics = <TopicListItem>[];
  _NodeContainerState({this.node});
  UserService userService = new UserService();


  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: const Color(0xffDEDEde),
      child: _buildRefreshTab(),
    );
  }

  List<Widget> _buildList(List<TopicListItem> topics) {
    List<Widget> list = <Widget>[];
    for (TopicListItem topic in topics) {
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
    if (!mounted) return;
    setState(() {
    });
  }
}


