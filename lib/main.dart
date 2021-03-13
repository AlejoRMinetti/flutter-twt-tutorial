import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tim & CHAMA App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Stateful widget: TextInput')),
        body: TextInputWidget());
  }
}

// Responsable for taking construction arguments, etc
class TextInputWidget extends StatefulWidget {
  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

// Resposable for render and handling each state
class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();
  String text = "";

/*   void dispose() {
    super.dispose();
    controller.dispose();
  } */

  void changeText(text) {
    if (text == "chau text") {
      controller.clear();
      text = "";
    }
    setState(() { // force to refresh the widget
      this.text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: this.controller,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.message), labelText: "Type a message:"),
          onChanged: (text) => this.changeText(text),
        ),
        Text(this.text)
      ],
    );
  }
}
