import 'package:flutter/material.dart';
import 'dart:async';


class UrlText extends StatefulWidget {
  final String text;
  final String url;
  final GestureTapCallback onTap;
  final UrlTextStyle style;
  UrlText({
    @required this.text,
    @required this.url,
    this.onTap,
    this.style,
  }): assert(text != null),
        assert(url != null);

  @override
  State<UrlText> createState() => _UrlText();
}

class _UrlText extends State<UrlText> {
  Text textWidget;
  UrlTextStyle _style;
  TextStyle _currentStyle;

  TextStyle _activeStyle;
  static Widget createTextWidget(String text){
    return Text(text);
  }

  @override
  void initState() {
    super.initState();
    _style = UrlTextStyle(
      normal: widget.style != null ? widget.style.normal : null,
      active: widget.style != null ? widget.style.active : null,
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
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
    );
  }

  void _onTapDown(TapDownDetails details){
    widget.onTap();
    print('tap!');
    _currentStyle = _style.active;
    setState(() {});
  }

  void _onTapUp(TapUpDetails details) {
    print('tap up!');
    Future.delayed( const Duration(milliseconds: 300), () {
      print('timeout!');
      _currentStyle = _style.normal;
      setState(() {});
    });
  }

}



class UrlTextStyle {
  TextStyle normal;
  TextStyle active;

  UrlTextStyle({
    this.normal,
    this.active,
  }) {
    normal = normal ?? TextStyle(
      color: Color(0xff1155cc),
    );
    active = active ?? TextStyle(
      color: Color(0xff000000),
    );
  }
}