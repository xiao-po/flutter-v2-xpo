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
        child: new Material(
          borderRadius: BorderRadius.all(
              Radius.circular(4.0)
          ),
          child: new InkWell(
            onTap: () {
              print("card touch");
            },
            child: new Row(
                children: <Widget>[
                  createHeaderImage(topic.author),
                  createTopicContent(topic),
                  createTopicReplyCount(topic)
                ],
            ),
          )
        ),
      ),
    );
  }

  Widget createHeaderImage(User user) {
    String imageUrl = user.avatar_normal != null ? user.avatar_normal : "";
    if (user.avatar_normal != null) {
      print(user.avatar_normal);
    }
    print(imageUrl);
    return InkWell (
      child: new Container(
          width: 70,
          child: new Center(
            child: CachedNetworkImage(
              placeholder: CircularProgressIndicator(),
              errorWidget: new Image.asset('assets/images/error.jpg'),
              imageUrl: imageUrl ,
            ),
          )
      ),
    );
  }

  Widget createTopicContent(Topic topic) {
    return new Expanded(
      flex: 1,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: new Padding(
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
            height: 60,
          ),
          new Container(
            height: 50,
            child: createTopicInfo(topic),
          )
        ],
      ),
    );
  }

  Widget createTopicInfo(Topic topic) {
    return new Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: new Row(
        children: <Widget>[
          new Text(topic.author.username),
          NodeButton(
              topic: topic,
              radius: 20,
          )
        ],
      ),
    );
  }

  Widget createTopicReplyCount(Topic topic)  {
    if (topic.replyCount != '' && topic.replyCount != null) {
      return new Container(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: new Container(
          padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
          child: new Text(
            topic.replyCount,
            textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffe2e2e2),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
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

class NodeButton extends StatelessWidget {
  final Topic topic;
  final double radius;
  final int color;
  const NodeButton({
    this.topic,
    this.radius,
    this.color
  }):
        assert(topic != null),
        assert(radius != null);

  @override
  Widget build(BuildContext context) {
    int trueColor = color != null ? color : 0xffe3e3e3;
    return  Container(
      margin: const EdgeInsets.only(left: 10.0),
      child: new Material(
        color: Color(trueColor),
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),

        child: new InkWell(
          onTap: () {
            print('button press');
          },
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          child: Container(
            child: new Text(topic.node.name),
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          ),
        ),
      ),
    );
  }
}