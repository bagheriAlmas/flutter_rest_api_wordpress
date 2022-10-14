import 'package:flutter/material.dart';
import 'package:flutter_app1/API.dart';

import '../Model/Post.dart';

class UpdatePostActivity extends StatelessWidget {
  const UpdatePostActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: UpdatePostPage());
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
        title: Text("Update Post"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: futurePost,
              builder: (context, AsyncSnapshot<Post?> snapshot) {
                if (snapshot.hasData) {
                  txtTitle.text = snapshot.data!.title.toString();
                  txtContent.text = snapshot.data!.content.toString();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

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
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                boolEditMode = !boolEditMode;
                              });
                            },
                            child: Text("Update"),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(child: CircularProgressIndicator());
              },
            ),

            Visibility(
              visible: boolEditMode,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                          controller: txtTitle,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Title")),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.rtl,
                          minLines: 5,
                          maxLines: 10,
                          controller: txtContent,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Content")),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text("Save"),
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
