import 'package:meta/meta.dart';
import 'package:xml/xml/nodes/element.dart';
import 'package:v2_xpo/service/userService.dart';
import 'package:html/dom.dart';

class VNode {
  String name;
  String eName;

  VNode(@required this.eName,@required this.name):
        assert(eName != null),
        assert(name != null),
        super();
}

class Topic {
  String title;
  String link;
  NodeDetail node;
  User author;
  User lastReplier;
  String replyCount;
  String lastReplyTimeString;
  String content;



  Topic();



  factory Topic.fromHtml(Element html) {
    Topic topic = new Topic();
    String title;
    User author;
    NodeDetail node = new NodeDetail();
    User lastReplier;
    String replyCount;
    String lastReplyTimeString;

    Element titleElement = html.querySelector(".item_title a");
    topic.link = titleElement.attributes['src'];
    topic.title = titleElement.text;
    
    Element topicInfoElement = html.querySelector(".topic_info");
    Element topicNodeInfo = topicInfoElement.querySelector("a.node");
    node.name = topicNodeInfo.text;
    node.nodeUrl = topicNodeInfo.attributes['src'];
    topic.node = node;
    Element replyCountElement = html.querySelector('.count_livid');

    if (replyCountElement != null) {
      topic.replyCount = replyCountElement.text;
    }

    topic.lastReplyTimeString =  topicInfoElement.text;
    List<Element> userElement = topicInfoElement.querySelectorAll("strong a");
    String username = userElement[0].text;
    String uri = userElement[0].attributes['src'];
    topic.author = new User.simple(username: username, uri: uri);
    topic.author.avatar_normal = html.querySelector("img.avatar").attributes["src"];
    if ((new RegExp("^//")).firstMatch(topic.author.avatar_normal) != null) {
      topic.author.avatar_normal = 'https:' + topic.author.avatar_normal;
    }

    if (userElement.length == 2) {
      username = userElement[1].text;
      uri = userElement[1].attributes['src'];
      lastReplier = new User.simple(username: username, uri: uri);
      topic.lastReplier = lastReplier;
    }

    return  topic;
  }
}


class NodeDetail {
  String name;
  String nodeUrl;
}


class User {
  String username;
  String uri;
  String status;
  int id;
  String url;
  String github;
  String tagline;
  String bio;
  String avatar_mini;
  String avatar_normal;
  String avatar_large;
  DateTime created;
  User({
    this.username,
    this.uri,
    this.status,
    this.id,
    this.github,
    this.tagline,
    this.bio,
    this.avatar_mini,
    this.avatar_large,
    this.avatar_normal,
    this.created
  }) ;
  User.simple({
    this.username,
    this.uri,
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    if ((new RegExp("^//")).firstMatch(json['avatar_mini']) != null) {
      json['avatar_mini'] = 'https:' +json ['avatar_mini'];
    }

    if ((new RegExp("^//")).firstMatch(json['avatar_large']) != null) {
      json['avatar_large'] = 'https:' +json ['avatar_large'];
    }

    if ((new RegExp("^//")).firstMatch(json['avatar_normal']) != null) {
      json['avatar_normal'] = 'https:' +json ['avatar_normal'];
    }

    return new User(
      username: json['username'],
      uri: json['uri'],
      status: json['status'],
      id: json['id'],
      github: json['github'],
      tagline: json['tagline'],
      bio: json['bio'],
      avatar_mini: json['avatar_mini'],
      avatar_large: json['avatar_large'],
      avatar_normal: json['avatar_normal'],
      created: new DateTime.fromMicrosecondsSinceEpoch(json['created']),
    );
  }
}