import 'package:v2_xpo/value/value.dart';

class XmlHttpApi {
  static String DomainUrl(nodeName) {
    return AppHttpValue.url + '/?tab=' + nodeName;
  }

  static String TopicUrl(nodeName) {
    return AppHttpValue.url + nodeName;
  }

}