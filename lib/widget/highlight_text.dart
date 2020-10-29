import 'package:flutter/material.dart';

class HighlightText extends StatelessWidget {
  final String text;
  final String highlight;
  final TextStyle style;
  final Color highlightColor;
  final bool ignoreCase;

  const HighlightText({
    Key key,
    this.text,
    this.highlight,
    this.style,
    this.highlightColor,
    this.ignoreCase: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = this.text ?? '';
    if ((highlight?.isEmpty ?? true) || text.isEmpty) {
      return Text(text, style: style);
    }

    List<TextSpan> spans = [];
    int start = 0;
    int index;
    do {
      if (ignoreCase) {
        index = text.toLowerCase().indexOf(highlight.toLowerCase(), start);
      } else {
        index = text.indexOf(highlight, start);
      }
      if (index < 0) {
        spans.add(_normalSpan(text.substring(start)));
        break;
      }
      if (index > start) {
        spans.add(_normalSpan(text.substring(start, index)));
      }
      start = index + highlight.length;
      spans.add(_highlightSpan(text.substring(index, start)));
    } while (true);

    return Text.rich(TextSpan(children: spans));
  }

  TextSpan _highlightSpan(String content) {
    return TextSpan(text: content, style: (style ?? const TextStyle()).copyWith(color: highlightColor));
  }

  TextSpan _normalSpan(String content) {
    return TextSpan(text: content, style: style);
  }
}
