import 'richTextElement.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:v2_xpo/component/basic/basic.dart';

class RichTextConverter {
  static List<Widget> parseToWidgetFromRichTextElement(
      List<RichTextContentElement> contentElements) {
    List<Widget> list = List();
    for (RichTextContentElement element in contentElements) {
      list.addAll(createBlockWidgetByType(element));
    }
    return list;
  }

  static List<Widget> createBlockWidgetByType(RichTextContentElement element) {
    switch (element.type) {
      case ContentType.p:
        return createParagraphTree(element);
        break;
      case ContentType.img:
        return createImageElement(element);
        break;
      case ContentType.pre:
        return createPreAreaWidget(element);
        break;
      case ContentType.code:
        return createCodeAreaWidget(element);
        break;
      case ContentType.ol:
        return createParagraphTree(element);
        break;
      case ContentType.ul:
        return createUlListWidget(element);
        break;
      case ContentType.li:
        return createParagraphTree(element);
        break;
      case ContentType.h1:
        return createH1Widget(element);
        break;
      case ContentType.h2:
        return createH2Widget(element);
        break;

      case ContentType.a:
        return [createLinkElement(element)];
        break;
      case ContentType.text:
      case ContentType.span:
        return [createTextWidget(element)];
        break;
      default:
        ;
    }
  }

  static Widget createTextSpanByType(RichTextContentElement element) {
    switch (element.type) {
      case ContentType.br:
        return createBreakText();
        break;
      case ContentType.a:
        return createLinkElement(element);
        break;
      case ContentType.text:
      case ContentType.span:
        return createTextWidget(element);
        break;
      case ContentType.strong:
        return createStrongTextWidget(element);
        break;
      default:
        return Text("");
    }
  }

  static Widget createBreakText() {
    return Text('\n');
  }

  static List<Widget> createParagraphTree(MarkDownContentElement element) {
    if (isImageParagraph(element)) {
      return createImageElement(element);
    }
    return createParagraphChildren(element);
  }

  static List<Widget> createParagraphChildren(MarkDownContentElement element) {
    List<Widget> list = new List();
    if (element.children != null && element.children.length > 0) {
      for (RichTextContentElement element in element.children) {
        if (element.isBlockElement()) {
          list.addAll(createBlockWidgetByType(element));
        } else {
          list.add(createInlineTextWidget(element));
        }
      }
      return list;
    } else {
      return list;
    }
  }

  static Text createTextWidget(RichTextContentElement element) {
    return Text(element.content);
  }

  static List<Widget> createImageElement(RichTextContentElement element) {
    return [
      CachedNetworkImage(
        placeholder: CircularProgressIndicator(),
        errorWidget: Image.asset('assets/images/error.jpg'),
        imageUrl: element.content,
      )
    ];
  }

  static RichText createLinkElement(LinkContentElement element) {
    return RichText(
      text: LinkTextSpan(
          text: element.content,
          url: element.url,
          style: TextStyle(
            color: Color(0xff1155cc),
          )),
    );
  }

  static List<Widget> createPreAreaWidget(RichTextContentElement element) {
    return createCodeAreaWidget(element);
  }

  static List<Widget> createCodeAreaWidget(RichTextContentElement element) {
    return createParagraphChildren(element);
  }

  static Widget createInlineTextWidget(RichTextContentElement element) {
    return new Text(element.content);
  }

  static Widget createStrongTextWidget(RichTextContentElement element) {
    return new Text(element.content,
        style: TextStyle(fontWeight: FontWeight.bold));
  }

  static bool isImageParagraph(MarkDownContentElement elements) {
    for (RichTextContentElement element in elements.children) {
      if (element.type == ContentType.img) {
        return true;
      }
    }
    return false;
  }

  static List<Widget> createH1Widget(RichTextContentElement element) {
    return [
      Container(
        child: Text(
          element.content,
          style: TextStyle(
            fontSize: 22
          ),
        ),
        decoration: new BoxDecoration(
            border: new Border(
                bottom: BorderSide(
                    color: Color(0xffccccccc),
                    width: 1.0,
                    style: BorderStyle.solid)
            )
        ),
      )
    ];
  }

  static List<Widget> createH2Widget(RichTextContentElement element) {
    return [
      Container(
        child: Text(
          element.content,
          style: TextStyle(
              fontSize: 22
          ),
        ),
        decoration: new BoxDecoration(
            border: new Border(
                bottom: BorderSide(
                    color: Color(0xffccccccc),
                    width: 1.0,
                    style: BorderStyle.solid)
            )
        ),
      )
    ];
  }

  static List<Widget> createUlListWidget(MarkDownContentElement element) {
    List list = List();
    for (MarkDownContentElement item in element.children) {
      list.add(createUlItemWidget(item));
    }
    return list;
  }

  static Widget createUlItemWidget(MarkDownContentElement item) {
    return
  }
}
