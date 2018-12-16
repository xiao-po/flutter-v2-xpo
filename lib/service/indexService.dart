
import 'dart:async';
import 'package:v2_xpo/value/HttpApi/XmlApi.dart';
import 'package:v2_xpo/model/model.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:dio/dio.dart';

class IndexService {
  static Future<List<TopicListItem>> getIndexHtmlData(VNode node) async {
    String url = XmlHttpApi.DomainUrl(node.eName);
    Dio dio = new Dio();
    Response<String> response = await dio.get(url);
    var document = parse(response.data);
    List<Element> topicList = document.querySelectorAll(".cell.item");
    List<TopicListItem> topics = <TopicListItem>[];
    topicList.forEach((entity)=> topics.add(TopicListItem.fromHtml(entity)));
    return topics;
  }

  static Future<Topic> getReplyData(String replyUrl) async {
    String url = XmlHttpApi.TopicUrl(replyUrl);
    print(url);
    Dio dio = new Dio();
    Response<String> response = await dio.get(url);
    var document = parse(response.data);
    Element topicContentElement = document.querySelector("#Main").querySelector(".box");
    Topic topic = Topic.getTopicContentFromHtml(topicContentElement);

    return topic;
  }
}
