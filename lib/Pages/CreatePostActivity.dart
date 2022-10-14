import 'package:flutter/material.dart';
import 'package:flutter_app1/API.dart';

import '../Model/Post.dart';

class CreatePostActivity extends StatelessWidget {
  const CreatePostActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtContent = TextEditingController();

  Future<Post>? futureResponse;

  FutureBuilder futureResponseBuilder() {
    return FutureBuilder(
      future: futureResponse,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text("Data Send Success");
        } else if (snapshot.hasError) {
          return Text("Data Send Error");
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: txtTitle,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Title")),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: txtContent,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Content")),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text("Create Post"),
              onPressed: () {
                setState(() {
                  futureResponse = createPost(txtTitle.text, txtContent.text);
                });
              },
            ),
          ),
          futureResponse == null ? Text("") : futureResponseBuilder(),
        ],
      ),
    );
  }
}
