import 'package:flutter/material.dart';
import 'post.dart';
import 'postList.dart';
import 'textInputWidget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];

  void newPost(String text) {
    this.setState(() {
      posts.add(new Post(text, "CHAMA"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Making a List of posted texts')),
        body: Column(
          children: <Widget>[
            Expanded(
                // expanded for get space from available free space
                child: PostList(this.posts)),
            TextInputWidget(this.newPost)
          ],
        ));
  }
}