import 'package:flutter/material.dart';

//class UrlText extends Text {
//  final String text;
//  final String url;
//  UrlText({
//    this.text,
//    this.url
//  }): super(
//      text,
//      style: TextStyle(
//        color: Color(0xff005999),
//      )
//  ) {
//
//  }
//}

class UrlText extends StatefulWidget {
  final String text;
  final String url;
  final GestureTapCallback onTap;
  final _UrlTextStyle style;
  UrlText({
    @required this.text,
    @required this.url,
    this.onTap,
    this.style,
  }): assert(text != null),
        assert(url != null);

  @override
  State<StatefulWidget> createState() => _UrlText();
}

class _UrlText extends State<UrlText> {
  Text textWidget;
  _UrlTextStyle _style;
  TextStyle _currentStyle;

  TextStyle _activeStyle;
  static Widget createTextWidget(String text){
    return Text(text);
  }

  _UrlText() {
    _style = _UrlTextStyle(
      normal: widget.style.normal,
      active: widget.style.active
    );
    _currentStyle = _style.normal;
  }
  @override
  GestureDetector build(BuildContext context){
    textWidget = Text(
      widget.text,
      style: _currentStyle,
    );
    return GestureDetector(
      child: textWidget,
      onTap: _onTap,
      onTapUp: _onTapUp,
    );
  }

  void _onTap(){
    widget.onTap();
    _currentStyle = widget.style.active;
    setState(() {});
  }

  void _onTapUp(TapUpDetails details) {
    _currentStyle = widget.style.normal;
    setState(() {});
  }

}



class _UrlTextStyle {
  TextStyle normal;
  TextStyle active;

  _UrlTextStyle({
    this.normal,
    this.active,
  }) {
    normal = normal ?? TextStyle(
      color: Color(0xff1155cc),
    );
    active = active ?? TextStyle(
      color: Color(0xff1155cc),
    );
  }
}