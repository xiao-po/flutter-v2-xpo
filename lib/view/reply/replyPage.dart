import 'package:flutter/material.dart';
import 'package:v2_xpo/model/model.dart';
import 'package:v2_xpo/service/appService.dart';

class ReplyPage extends StatefulWidget{
  static const String routeName = '/reply';
  static const String title = '查看回复';

  const ReplyPage({
    this.topicItem
  }):
    assert(topicItem != null);

  final TopicListItem topicItem;
  @override
  State<StatefulWidget> createState() {
    return _ReplyPageState(topicItem: topicItem);
  }

}

class _ReplyPageState extends State<ReplyPage> {

  _ReplyPageState({
    this.topicItem
  }):
        assert(topicItem != null);

  final TopicListItem topicItem;
  @override
  Widget build(BuildContext context) {
    IndexService.getReplyData(topicItem.link);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(ReplyPage.title),
      ),
      body: Container(
        child: Center(
          child: Text(topicItem.title)
        ),
      ),
    );
  }

}