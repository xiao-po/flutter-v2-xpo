import 'richTextElement.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RichTextConverter {
  static List<Widget> parseToWidgetFromRichTextElement (List<RichTextContentElement> contentElements) {
    List<Widget> list = List();
    for (RichTextContentElement element in contentElements) {

    }
  }

  static Widget createWidgetByType(RichTextContentElement element) {
    switch(element.type) {
      case ContentType.br: return createBreakText(); break;
      case ContentType.p:  return createParagraphTree(element);break;
      case ContentType.img:  return createImageElement(element);break;
      case ContentType.a:  return createLinkElement(element);break;
      case ContentType.pre:  break;
      case ContentType.code:  break;
      case ContentType.span:  break;
      case ContentType.strong:  break;
      case ContentType.ol:  break;
      case ContentType.ul:  break;
      case ContentType.li:  break;
      case ContentType.h1:  break;
      case ContentType.h2:  break;
      case ContentType.text: return createTextWidget(element);break;
      default:;
    }
  }

  static Widget createBreakText() {
    return Text('\n');
  }

  static Widget createParagraphTree(MarkDownContentElement element) {
    return Wrap(
      children: createParagraphChildren(element)
    );
  }

  static List<Widget> createParagraphChildren
      (MarkDownContentElement element) {
    List<Widget> list = new List();
    if (element.children != null && element.children.length > 0 ) {
      for (RichTextContentElement element in element.children) {
        list.add(createWidgetByType(element));
      }
    } else  {
      return list;
    }
    return null;
  }

  static Widget createTextWidget(RichTextContentElement element) {
    return Text(element.content);
  }

  static Widget createImageElement(RichTextContentElement element) {
    return  CachedNetworkImage(
      placeholder: CircularProgressIndicator(),
      errorWidget: Image.asset('assets/images/error.jpg'),
      imageUrl: element.content ,
    );
  }

  static Widget createLinkElement(RichTextContentElement element) {}
}