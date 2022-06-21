import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/post.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    this.buttonKey,
    required this.title,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final Key? buttonKey;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Post? postData;
  Random rng = Random.secure();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              key: widget.buttonKey,
              onPressed: () async {
                int randomNumber = rng.nextInt(100) + 1;
                print(randomNumber);
                final response = await http.get(Uri.parse(
                    'https://jsonplaceholder.typicode.com/posts/$randomNumber'));
                if (response.statusCode == 200) {
                  // If server returns an OK response, parse the JSON.
                  setState(() {
                    postData = Post.fromJson(json.decode(response.body));
                  });
                } else {
                  // If that response was not OK, throw an error.
                  setState(() {
                    postData = Post(
                      userId: 1,
                      id: 1,
                      title: "Failed Download Data",
                      body: "",
                    );
                  });
                  developer.log('Failed to load post');
                }
              },
              child: Text(
                'Download Data',
              ),
            ),
            Text('${postData?.title}'),
            Text('${postData?.body}'),
          ],
        ),
      ),
    );
  }
}
