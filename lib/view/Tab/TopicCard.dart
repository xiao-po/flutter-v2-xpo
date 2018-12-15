import 'package:flutter/material.dart';
import 'package:v2_xpo/model/Node.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({Key key, Topic topic})
    : topic = topic;

  final Topic topic;
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: 120,
      child: new Card(
        child: new Row(
          children: <Widget>[
            createHeaderImage(topic.author),
            createTopicContent(topic),
            createTopicReplyCount(topic),
          ],
        ),
      )
    );
  }

  Widget createHeaderImage(User user) {
    String imageUrl = user.avatar_normal != null ? user.avatar_normal : "";
    if (user.avatar_normal != null) {
      print(user.avatar_normal);
    }
    print(imageUrl);
    return new Container(
      width: 70,
      child: new Center(
        child: CachedNetworkImage(
          placeholder: CircularProgressIndicator(),
          errorWidget: new Image.asset('assets/images/error.jpg'),
          imageUrl: imageUrl ,
        ),
      )
    );
  }

  Widget createTopicContent(Topic topic) {
    return new Expanded(
      flex: 1,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
            child: new Text(
              topic.title,
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,

              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          new Text(topic.author.username)
        ],
      ),
    );
  }

  Widget createTopicReplyCount(Topic topic)  {
    if (topic.replyCount != '' && topic.replyCount != null) {
      return new Container(
        width: 40,
        child: new Center(
          child: new Text(topic.replyCount),
        ),
      );
    } else {
      return new Container(
        width: 40,
        child: new Center(
          child: new Text(""),
        ),
      );
    }

  }
}
