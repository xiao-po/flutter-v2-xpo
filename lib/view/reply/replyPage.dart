import 'package:flutter/material.dart';
import 'package:v2_xpo/model/model.dart';
import 'package:v2_xpo/service/appService.dart';
import 'package:v2_xpo/utils/topicParser/parse.dart';

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
  Topic topic = null;
  _ReplyPageState({
    this.topicItem
  }):
        assert(topicItem != null);

  final TopicListItem topicItem;

  @override
  void initState() {
    super.initState();
    _getTopic();
  }

  Future<void> _getTopic() async {
    topic =await IndexService.getReplyData(topicItem.link);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(ReplyPage.title),
      ),
      body: RefreshIndicator(
            child: _buildReplyPage(),
            onRefresh: _getTopic,
      )
    );
  }

  _buildReplyPage() {
      if (topic != null && topic.content != null) {
        return Column(
          children:
            RichTextConverter
                .parseToWidgetFromRichTextElement(topic.content),
        );
      }
      return new Center(
          child: new CircularProgressIndicator()
      );
  }

}