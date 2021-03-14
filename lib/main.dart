import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Post {
  String body;
  String author;
  int likes = 0;
  bool userLiked = false;

  Post(this.body, this.author);

  void likePost() {
    this.userLiked = !this.userLiked;
    if (this.userLiked) {
      this.likes++;
    } else {
      this.likes--;
    }
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tim & CHAMA App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

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
            Expanded(child: TextInputWidget(this.newPost))
          ],
        ));
  }
}

class TextInputWidget extends StatefulWidget {
  final Function(String) callback;

  TextInputWidget(
      this.callback); // {param} makes an optional parameter (param: asd) [] optional unnamed, without any of this: mandatory param

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click() {
    widget.callback(controller.text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.message),
          labelText: "Type a message:",
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            splashColor: Colors.lightBlue,
            tooltip: "Post message to the list",
            onPressed: this.click,
          )),
    );
  }
}

class PostList extends StatefulWidget {
  final List<Post> listItems;

  PostList(this.listItems);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {

void like(Function callback){
  this.setState(() {
    callback();
  });
}

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.listItems.length,
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];
        return Card(
            child: Row(children: <Widget>[
          Expanded(
              child: ListTile(
            title: Text(post.body),
            subtitle: Text(post.author),
          )),
          Row(
            children: <Widget>[
              Container(child: Text(post.likes.toString(),
              style: TextStyle(fontSize: 20),),
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              ),
              IconButton(
                  icon: Icon(Icons.thumb_up_alt_rounded),
                  onPressed: () => like(post.likePost),
                  color: post.userLiked ? Colors.green : Colors.grey,
                  )
            ],
          )
        ]));
      },
    );
  }
}
