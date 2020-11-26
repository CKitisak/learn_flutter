import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

class DynamicWidget extends StatefulWidget {
  DynamicWidget({Key key}) : super(key: key);

  final url = 'http://192.168.1.111:1337/flutter/widgets';

  @override
  _DynamicWidgetState createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  Future<http.Response> _loadWidgets() async {
    return http.get(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<http.Response> snapshot) {
        if (snapshot.hasData) {
          var jsonWidget = convert.jsonDecode(snapshot.data.body);
          print('JsonWidget:${jsonWidget['data']}');
          var widget = JsonWidgetData.fromDynamic(jsonWidget['data']);
          return Scaffold(body: widget.build(context: context));
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      future: _loadWidgets(),
    );
  }
}
