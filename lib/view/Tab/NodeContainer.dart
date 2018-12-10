import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v2_xpo/model/Node.dart';
import 'package:v2_xpo/service/indexService.dart';

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
      list.add(new Text(topic.title));
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

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;

  Future<Null> _refresh() async{
    List topicTemp = await (node.eName == 'index' ? IndexService.getIndexData() : IndexService.getNodeData(node));
    if (!mounted) return;
    setState(() {
      topics = topicTemp;
    });
  }
}


