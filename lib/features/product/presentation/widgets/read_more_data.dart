import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/helper.dart';

class ReadMoreHtml extends StatefulWidget {
  final String htmlData;
  final int maxLength;
  final String readMoreText;
  final String readLessText;

  const ReadMoreHtml({Key? key, 
    required this.htmlData,
    required this.maxLength,
    required this.readMoreText,
    required this.readLessText,
  }) : super(key: key);

  @override
  _ReadMoreHtmlState createState() => _ReadMoreHtmlState();
}

class _ReadMoreHtmlState extends State<ReadMoreHtml> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    logMe('widget html data');
    if (widget.htmlData.length < 250) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Html(
            style: {
              '#': Style(
                fontSize: FontSize.medium,
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
                fontStyle: FontStyle.normal,
              ),
            },
            data: widget.htmlData,
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Html(
            style: {
              '#': Style(
                fontSize: FontSize.medium,
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
                fontStyle: FontStyle.normal,
              ),
            },
            data: isExpanded
                ? widget.htmlData
                : widget.htmlData.substring(0, 250) + "...",
          ),
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? widget.readLessText : widget.readMoreText,
              style: const TextStyle(color: secondaryColor),
            ),
          ),
        ],
      );
    }
  }
}
