import 'Node.dart';
import 'user.dart';
import 'package:html/dom.dart';

class _TopicModel {
  String title;
  NodeDetail node;
  User author;
}

enum ContentType {
  text,
  img,
  br
}
class _ContentElement {
  ContentType type;
  String content;
}

class StringContentElement extends _ContentElement {
  StringContentElement(String text) {
    type = ContentType.text;
    content = text;
  }
}

class Topic extends _TopicModel {
  String lastReplyTimeString;
  List<_ContentElement> content;
  int thanksCount;
  List<ReplyItem> replList;
  Topic (

      );
  factory Topic.getTopicContentFromHtml(Element topicContentHtml) {
    Topic topic = Topic();


    Element imgNode = topicContentHtml.querySelector(".fr>a>img");
    String headerUrl = imgNode.attributes['src'];



    Element nodeMessageElement = topicContentHtml.querySelectorAll(".header>a")[1];
    NodeDetail node = NodeDetail();
    node.name = nodeMessageElement.text;
    node.nodeUrl = nodeMessageElement.attributes['href'];

    topic.title = topicContentHtml.querySelector('.header>h1').text;

    Element smallElement = topicContentHtml.querySelector('.header>small');
    topic.author = User.simple(
        username: smallElement.children[0].text,
        uri: smallElement.children[0].attributes["href"]
    );
    topic.author.avatar_normal = headerUrl;

    Element contentElement = topicContentHtml.querySelector(".topic_content");
    if (contentElement.querySelector(".markdown_body") != null) {

    } else {
      if (contentElement.children != null
          && contentElement.children.length > 0){
        for(Node item in contentElement.nodes) {
          if (item is Text) {
            item = (item) as Text;
            // TODO： 添加 text 类型数据
          } else if (item is Element && ((item) as Element).attributes['localName'] == "br") {
            // TODO： 添加 换行符
          }
        }
      }
    }
    return topic;
  }


}

class TopicListItem extends _TopicModel{
  User lastReplier;
  String link;
  String replyCount;
  String lastReplyTimeString;



  TopicListItem();



  factory TopicListItem.fromHtml(Element html) {
    TopicListItem topic = new TopicListItem();
    NodeDetail node = new NodeDetail();
    User lastReplier;

    Element titleElement = html.querySelector(".item_title a");
    topic.link = titleElement.attributes['href'];
    topic.title = titleElement.text;

    Element topicInfoElement = html.querySelector(".topic_info");
    Element topicNodeInfo = topicInfoElement.querySelector("a.node");
    node.name = topicNodeInfo.text;
    node.nodeUrl = topicNodeInfo.attributes['href'];
    topic.node = node;
    Element replyCountElement = html.querySelector('.count_livid');

    if (replyCountElement != null) {
      topic.replyCount = replyCountElement.text;
    }

    topic.lastReplyTimeString =  topicInfoElement.text;
    List<Element> userElement = topicInfoElement.querySelectorAll("strong a");
    String username = userElement[0].text;
    String uri = userElement[0].attributes['href'];
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


class ReplyItem {
  String content;
  User user;
  int thanksCount;
  DateTime replyTime;
  String via;

  ReplyItem();
}