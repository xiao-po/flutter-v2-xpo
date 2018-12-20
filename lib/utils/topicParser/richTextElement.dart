import 'package:html/dom.dart';

enum ContentType {
  text,
  img,
  br,
  p,
  a,
  h1,
  h2,
  pre,
  code,
  span,
  strong,
  ol,
  li,
  ul

}
class RichTextContentElement {
  ContentType type;
  String content;


  bool isBlockElement(){
    switch(type) {
      case ContentType.p:
      case ContentType.img:
      case ContentType.pre:
      case ContentType.code:
      case ContentType.ol:
      case ContentType.ul:
      case ContentType.li:
      case ContentType.h1:
      case ContentType.h2:  return true;
      default: return false;
    }
  }
}

class StringContentElement extends RichTextContentElement {
  StringContentElement(String text) {
    type = ContentType.text;
    content = text;
  }
}

class BreakContentElement extends RichTextContentElement {
  BreakContentElement() {
    type = ContentType.br;
  }
}

class ImgContentElement extends RichTextContentElement {
  ImgContentElement(String url) {
    type = ContentType.img;
    content = url;
  }
}

class LinkContentElement extends RichTextContentElement {
  String url;
  LinkContentElement(String linkName, String linkUrl) {
    type = ContentType.a;
    content = linkName;
    url = linkUrl;
  }
}

class MarkDownContentElement extends RichTextContentElement {
  List<RichTextContentElement> children;
  String htmlClassName;
  MarkDownContentElement(ContentType newType) {
    type = newType;
  }
}

class ParseTextContent {

  static List<RichTextContentElement> toContentElementList(Element contentElement) {
    List<RichTextContentElement> list= new List();
    for(Node item in contentElement.nodes) {
      if (item is Text && item.text != "\n") {
        list.add(new StringContentElement(item.text));
      } else if (item is Element) {
        switch(item.localName) {
          case "br": list.add(BreakContentElement());break;
          case "p": list.add(createParagraphElement(item));break;
          case "img": list.add(createImageElement(item));break;
          case "a": list.add(createLinkElement(item));break;
          case "pre": list.add(createPreElement(item));break;
          case "code": list.add(createCodeElement(item));break;
          case "span": list.add(createSpanElement(item));break;
          case "strong": list.add(createStrongElement(item));break;
          case "ol": list.add(createOlElement(item));break;
          case "ul": list.add(createUlElement(item));break;
          case "li": list.add(createLiElement(item));break;
          case "h1": list.add(createH1Element(item));break;
          case "h2": list.add(createH2Element(item));break;
          default:;

        }
      }
    }
    return list;
  }


  static RichTextContentElement createParagraphElement (Element item){
    MarkDownContentElement contentElement =
      new MarkDownContentElement(ContentType.p);
    if (item.children != null && item.children.length > 0) {
      contentElement.children = toContentElementList(item);
    } else {
      contentElement.content = item.text;
    }
    return contentElement;
  }

  static RichTextContentElement createImageElement (Element item){
    return new ImgContentElement(item.attributes['src']);
  }

  static RichTextContentElement createLinkElement (Element item){
    return new LinkContentElement(item.text, item.attributes['href']);
  }

  static RichTextContentElement createPreElement (Element item){
    MarkDownContentElement contentElement =
      new MarkDownContentElement(ContentType.pre);
    contentElement.children = toContentElementList(item);
    return contentElement;
  }

  static RichTextContentElement createCodeElement (Element item){
    MarkDownContentElement contentElement =
      new MarkDownContentElement(ContentType.pre);
    if (item.className != null && item.className != '') {
      contentElement.htmlClassName = item.className;
    }
    contentElement.children = toContentElementList(item);
    return contentElement;
  }

  static RichTextContentElement createSpanElement (Element item){
    MarkDownContentElement contentElement =
      new MarkDownContentElement(ContentType.span);
    if (item.className != null && item.className != '') {
      contentElement.htmlClassName = item.className;
    }
    contentElement.content = item.text;
    return contentElement;
  }

  static RichTextContentElement createStrongElement (Element item){
    MarkDownContentElement contentElement =
      new MarkDownContentElement(ContentType.strong);
    contentElement.content = item.text;
    return contentElement;
  }
  
  static RichTextContentElement createOlElement (Element item) {
    MarkDownContentElement contentElement =
      new MarkDownContentElement(ContentType.ol);
    contentElement.children = toContentElementList(item);
    return contentElement;
  }

  static RichTextContentElement createUlElement (Element item) {
    MarkDownContentElement contentElement =
    new MarkDownContentElement(ContentType.ul);
    contentElement.children = toContentElementList(item);
    return contentElement;
  }

  static RichTextContentElement createLiElement (Element item) {
    MarkDownContentElement contentElement =
      new MarkDownContentElement(ContentType.li);
    contentElement.children = toContentElementList(item);
    return contentElement;
  }

  static RichTextContentElement createH1Element (Element item) {
    MarkDownContentElement contentElement =
    new MarkDownContentElement(ContentType.h1);
    contentElement.children = toContentElementList(item);
    return contentElement;
  }

  static RichTextContentElement createH2Element (Element item) {
    MarkDownContentElement contentElement =
    new MarkDownContentElement(ContentType.h2);
    contentElement.children = toContentElementList(item);
    return contentElement;
  }
}