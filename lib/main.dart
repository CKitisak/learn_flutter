import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'HTTP Request'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _jsonData;
  int count = 1;

  void _retrieveData() async {
    // on the real devices localhost, 127.0.0.1 will be something else
    // for Android emulator uses 10.0.2.2
    // for iOS emulator can use both localhost, 127.0.0.1
    var url = 'http://192.168.1.111:1337/flutter';
    // var url = 'https://api.ipify.org/?format=json';
    print('url: $url');
    // var response = await http.get(url);
    // var response = await http.post(url, body: 'Hey I am a payload');
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    var client = http.Client();
    var response;
    var jsondata;
    try {
      if (count == 1) {
        response = await http.get(url);
      } else {
        response = await client.post(url, body: 'Hey I am a payload $count');
      }
      jsondata = convert.jsonDecode(response.body);
      print('response: ${jsondata['payload']}');
    } finally {
      client.close();
    }

    setState(() {
      count++;
      _jsonData = convert.jsonEncode(jsondata['payload']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Card(
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: _jsonData != null
                  ? Text(_jsonData)
                  : CircularProgressIndicator())),
      floatingActionButton: FloatingActionButton(
        onPressed: _retrieveData,
        tooltip: 'Sync',
        child: Icon(Icons.sync),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
