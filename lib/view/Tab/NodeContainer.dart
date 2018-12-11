import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v2_xpo/model/Node.dart';
import 'package:v2_xpo/service/indexService.dart';
import 'package:v2_xpo/service/userService.dart';
import 'package:v2_xpo/view/Tab/TopicCard.dart';

class NodeContainer extends StatefulWidget {
  Node node;
  NodeContainer({this.node}):super();
  List<Topic> topics = <Topic>[];
  @override
  _NodeContainerState createState() => _NodeContainerState(node: node);
}

class _NodeContainerState extends State<NodeContainer>
    with AutomaticKeepAliveClientMixin{
  Node node ;
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
    topics = await (node.eName == 'index' ? IndexService.getIndexData() : IndexService.getNodeData(node));
    _getUserByTopics(topics);
    print("over");
    if (!mounted) return;
    setState(() {
    });
  }

  Future<void> _getUserByTopics (List<Topic> topicList) async {
    for (Topic topic in topicList) {
      await this.userService.getUserByName(topic.author.username);
      topic.author.avatar_large = "https://cdn.v2ex.com/avatar/8b75/b98f/305534_large.png";
      setState(() {
        topics = topicList;
      });
    }

  }
}


