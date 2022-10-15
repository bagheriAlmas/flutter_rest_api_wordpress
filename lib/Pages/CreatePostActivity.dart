import 'package:flutter/material.dart';
import 'package:flutter_app1/API.dart';

import '../Model/Post.dart';

class CreatePostActivity extends StatelessWidget {
  const CreatePostActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          return Text("اطلاعات با موفقیت ارسال شد");
        } else if (snapshot.hasError) {
          return Text("خطا در ارسال اطلاعات");
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ایجاد پست جدید"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                    controller: txtTitle,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "عنوان")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  minLines: 3,
                  maxLines: 3,
                  textDirection: TextDirection.rtl,
                    controller: txtContent,
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                        border: OutlineInputBorder(), labelText: "محتوا")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text("ایجاد پست"),
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
      ),
    );
  }
}
