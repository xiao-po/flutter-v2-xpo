
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:v2_xpo/config/HttpApi/XmlApi.dart';
import 'package:v2_xpo/config/value.dart';
import 'package:v2_xpo/model/Node.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:dio/dio.dart';

class IndexService {
//  static Future<List<Topic>> getIndexData() async{
//    String url = XmlHttpApi.INDEX_XML_API;
//    print(url);
//    try {
//      Dio dio = new Dio();
//      Response<String> response = await dio.get(url);
//      XmlDocument xmlDocument = xml.parse(response.data);
//      Iterable<XmlElement> entities = xmlDocument.findAllElements("entry");
//      List<Topic> topics = <Topic>[];
//      entities.forEach((entity)=> topics.add(Topic.fromXml(entity)));
//      return topics;
//    } catch (e) {
//      print(e);
//      await Fluttertoast.showToast(msg: AppHttpValue.NET_ERROR_MESSAGE);
//    }
//    return null;
//  }
//
//
//  static Future<List<Topic>> getNodeData(VNode node) async{
//    String url = XmlHttpApi.NODE_FEED_API(node.eName);
//    print(url);
//    try {
//      Dio dio = new Dio();
//      Response<String> response = await dio.get(url);
//      XmlDocument xmlDocument = xml.parse(response.data);
//      Iterable<XmlElement> entities = xmlDocument.findAllElements("entry");
//      List<Topic> topics = <Topic>[];
//      entities.forEach((entity)=> topics.add(Topic.fromXml(entity)));
//      return topics;
//    } catch (e) {
//      print(e);
//      await Fluttertoast.showToast(msg: AppHttpValue.NET_ERROR_MESSAGE);
//    }
//    return null;
//  }


  static Future<List<Topic>> getIndexHtmlData(VNode node) async {
    String url = XmlHttpApi.DomainUrl(node.eName);
    print(url);
    Dio dio = new Dio();
    Response<String> response = await dio.get(url);
    var document = parse(response.data);
    List<Element> topicList = document.querySelectorAll(".cell.item");
    List<Topic> topics = <Topic>[];
    topicList.forEach((entity)=> topics.add(Topic.fromHtml(entity)));
    return topics;
  }
}
