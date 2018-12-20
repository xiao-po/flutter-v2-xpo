import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

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
    _currentStyle = _style.active;
    setState(() {});
  }

  void _onTapUp(TapUpDetails details) {
    print('tap up!');
    Future.delayed( const Duration(milliseconds: 300), () {
      _currentStyle = _style.normal;
      setState(() {});
      launch(widget.url, forceWebView: true);
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


class LinkTextSpan extends TextSpan {

  // Beware!
  //
  // This class is only safe because the TapGestureRecognizer is not
  // given a deadline and therefore never allocates any resources.
  //
  // In any other situation -- setting a deadline, using any of the less trivial
  // recognizers, etc -- you would have to manage the gesture recognizer's
  // lifetime and call dispose() when the TextSpan was no longer being rendered.
  //
  // Since TextSpan itself is @immutable, this means that you would have to
  // manage the recognizer from outside the TextSpan, e.g. in the State of a
  // stateful widget that then hands the recognizer to the TextSpan.

  LinkTextSpan({ TextStyle style, String url, String text }) : super(
      style: style,
      text: text ?? url,
      recognizer: TapGestureRecognizer()..onTap = () {
        launch(url, forceWebView: true);
      }
  );
}