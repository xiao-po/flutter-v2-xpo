import 'package:meta/meta.dart';
import 'package:xml/xml/nodes/document.dart';
import 'package:xml/xml/nodes/element.dart';

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


  factory Topic.fromXml(XmlElement xml){
    String title;
    String link;
    DateTime publishTime;
    DateTime updateTime;
    User author;
    String content;
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
      String name = authorNode.findElements("name").toList()[0].text;
      String uri = authorNode.findElements("uri").toList()[0].text;
      author = new User(name, uri);
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
  String name;
  String uri;

  User(this.name, this.uri);

}