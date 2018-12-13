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
            this.createHeaderImage(topic.author),
            this.createTopicContent(topic),
          ],
        ),
      )
    );
  }

  Widget createHeaderImage(User user) {
    String imageUrl = user.avatar_large != null ? user.avatar_large : "111";
    if (user.avatar_large != null) {
      print(user.avatar_large);
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
        children: <Widget>[
          new Text(
            topic.title,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,

            ),
          ),
          new Text(topic.author.username)
        ],
      ),
    );
  }
}
