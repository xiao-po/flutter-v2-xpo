import 'package:v2_xpo/config/value.dart';

class XmlHttpApi {
  static String NODE_MESSAGE_BY_NAME = 'api/nodes/show.json?name=';

  static String INDEX_XML_API = AppHttpValue.url + "index.xml";
  static String NODE_FEED_API(nodeName){
    return AppHttpValue.url + 'feed/' + nodeName + '.xml';
  }



}