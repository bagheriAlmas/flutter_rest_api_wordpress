import 'package:flutter/material.dart';
import 'package:flutter_app1/API.dart';

import '../Model/Post.dart';

class UpdatePostActivity extends StatelessWidget {
  const UpdatePostActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UpdatePostPage());
  }
}

class UpdatePostPage extends StatefulWidget {
  final String? id;

  const UpdatePostPage({Key? key, this.id}) : super(key: key);

  @override
  State<UpdatePostPage> createState() => _UpdatePostPageState();
}

class _UpdatePostPageState extends State<UpdatePostPage> {
  bool boolEditMode = false;

  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtContent = TextEditingController();


  late Future<Post> futurePost;

  @override
  void initState() {
    futurePost = fetchPostById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(" ویرایش پست"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !boolEditMode,
              child: FutureBuilder(
                future: futurePost,
                builder: (context, AsyncSnapshot<Post?> snapshot) {
                  if (snapshot.hasData) {
                    txtTitle.text = snapshot.data!.title.toString();
                    txtContent.text = snapshot.data!.content.toString();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: [
                          Card(
                            child: ListTile(
                              title: Text(
                                snapshot.data!.title.toString(),
                                textDirection: TextDirection.rtl,
                              ),
                              subtitle: Text(
                                snapshot.data!.content.toString(),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  boolEditMode = !boolEditMode;
                                });
                              },
                              child: Text("ویرایش"),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ));
                },
              ),
            ),

            Visibility(
              visible: boolEditMode,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                            controller: txtTitle,
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(), labelText: "عنوان")),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            minLines: 3,
                            maxLines: 3,
                            controller: txtContent,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "محتوا")),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text("ذخیره"),
                          onPressed: (){
                          setState(() {
                            futurePost = UpdatePost(widget.id!, txtTitle.text, txtContent.text);
                            boolEditMode = !boolEditMode;
                          });
                          },),
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
