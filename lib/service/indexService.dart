
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as Http;
import 'package:v2_xpo/config/HttpApi/XmlApi.dart';
import 'package:v2_xpo/config/value.dart';
import 'package:v2_xpo/model/Node.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart';


class IndexService {
  static Future<List<Topic>> getIndexData() async{
    String url = XmlHttpApi.INDEX_XML_API;
    print(url);
    try {
      final Http.Response response = await Http.get(url);
      XmlDocument xmlDocument = xml.parse(response.body);
      Iterable<XmlElement> entities = xmlDocument.findAllElements("entry");
      List<Topic> topics = <Topic>[];
      entities.forEach((entity)=> topics.add(Topic.fromXml(entity)));
      return topics;
    } catch (e) {
      print(e);
      await Fluttertoast.showToast(msg: AppHttpValue.NET_ERROR_MESSAGE);
    }
    return null;
  }
  static Future<List<Topic>> getNodeData(Node node) async{
    String url = XmlHttpApi.NODE_FEED_API(node.eName);
    print(url);
    try {
      final Http.Response response = await Http.get(url);
      XmlDocument xmlDocument = xml.parse(response.body);
      Iterable<XmlElement> entities = xmlDocument.findAllElements("entry");
      List<Topic> topics = <Topic>[];
      entities.forEach((entity)=> topics.add(Topic.fromXml(entity)));
      return topics;
    } catch (e) {
      print(e);
      await Fluttertoast.showToast(msg: AppHttpValue.NET_ERROR_MESSAGE);
    }
    return null;
  }
}
