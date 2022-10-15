import 'package:flutter/material.dart';
import 'package:flutter_app1/API.dart';
import 'package:flutter_app1/Pages/UpdatePostActivity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'Model/Post.dart';
import 'Pages/CreatePostActivity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Post>? futureAlbum;

  RefreshController _refreshController = RefreshController();

  void _onRefresh() async {
    await fetchAllPosts().then((value) {
      setState(() {
        futureAlbum = value;
      });
    });
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    fetchAllPosts().then((value) {
      futureAlbum = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("دریافت اطلاعات از وردپرس"),),
      body: Center(
        child: FutureBuilder(
          future: fetchAllPosts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: ListView.builder(
                  itemCount: futureAlbum?.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(),
                      secondaryBackground: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.redAccent,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        DeletePost(futureAlbum![index].id.toString());

                        fetchAllPosts().then((value) {
                          setState(() {
                            futureAlbum = value;
                          });
                        });
                      },
                      key: Key(futureAlbum![index].id.toString()),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return UpdatePostPage(
                                    id: futureAlbum![index].id.toString());
                              },
                            ));
                          },
                          trailing: Text(futureAlbum![index].id.toString()),
                          title: Text(futureAlbum![index].title.toString(),
                              textDirection: TextDirection.rtl),
                          subtitle: Text(
                            futureAlbum![index].content.toString(),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.justify,
                          ),
                          leading: Text(
                            futureAlbum![index].date.toString().substring(0,10),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("${snapshot.error.toString()}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return CreatePostActivity();
            },
          ));
        },
      ),
    );
  }
}
