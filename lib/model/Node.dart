import 'package:meta/meta.dart';
import 'package:xml/xml/nodes/document.dart';
import 'package:xml/xml/nodes/element.dart';
import 'package:v2_xpo/service/userService.dart';
import 'package:dio/dio.dart';

class Node {
  String name;
  String eName;

  Node(@required this.eName,@required this.name):
        assert(eName != null),
        assert(name != null),
        super();
}

class Topic {
  String title;
  String link;
  DateTime publishTime;
  DateTime updateTime;
  User author;
  String content;



  Topic(this.title, this.link, this.publishTime, this.updateTime, this.author,
      this.content);


  factory Topic.fromXml(XmlElement xml) {
    String title;
    String link;
    DateTime publishTime;
    DateTime updateTime;
    User author;
    String content;
    UserService userService = new UserService();
    xml.findElements("title").forEach((element){
      title = element.text;
    });
    xml.findElements("link").forEach((element){
      link = element.text;
    });
    xml.findElements("published").forEach((element){
      publishTime = DateTime.parse(element.text);
    });
    xml.findElements("updated").forEach((element){
      updateTime = DateTime.parse(element.text);
    });
    xml.findElements("author").forEach((element){
      XmlElement authorNode = element;
      String username = authorNode.findElements("name").toList()[0].text;
      String uri = authorNode.findElements("uri").toList()[0].text;
      author = new User.simple(username: username, uri: uri);
    });
    xml.findElements("content").forEach((element){
      content = element.text;
    });
    return new Topic(title, link, publishTime, updateTime, author, content);
  }


}

class TopicFactory {
  fromXml(XmlDocument xml){

  }
}

class User {
  String username;
  String uri;
  String status;
  String id;
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

//  factory User.fromJSON(Map<String, dynamic> json) {
//    return new User(
//      username: json['username'],
//      uri: json['uri'],
//      status: json['status'],
//      id: json['id'],
//      github: json['github'],
//      tagline: json['tagline'],
//      bio: json['bio'],
//      avatar_mini: json['avatar_mini'],
//      avatar_large: json['avatar_large'],
//      avatar_normal: json['avatar_normal'],
//      created: new DateTime(json['created']),
//    );
//  }
}