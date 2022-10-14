import 'dart:convert';
import 'package:flutter_app1/Model/Post.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPostById(String? id) async {
  String strAuth = "Basic bWFoZGk6TmVnaW4zNTI2ISE=";

  final response = await http.get(
    Uri.parse("http://almasapps.ir/wp-json/wp/v2/posts/$id"),
    headers: <String, String>{
      'Authorization': strAuth,
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );
  if (response.statusCode == 200) {
    print("STATUS CODE : ${response.statusCode}");
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed To Load Data");
  }
}

Future<List<Post>?> fetchAllPosts() async {
  String strAuth = "Basic bWFoZGk6TmVnaW4zNTI2ISE=";

  final response = await http.get(
    Uri.http("almasapps.ir", "wp-json/wp/v2/posts/"),
    // Uri.parse("http://almasapps.ir/wp-json/wp/v2/posts/"),
    headers: <String, String>{
      'Authorization': strAuth,
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );
  if (response.statusCode == 200) {
    List<Post> postList = List<Post>.from(
      jsonDecode(response.body).map(
        (x) => Post.fromJson(x),
      ),
    );
    return postList;
    // return Post.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed To Load Data");
  }
}

Future<Post> createPost(String title, String content) async {
  String strAuth = "Basic bWFoZGk6TmVnaW4zNTI2ISE=";

  final response = await http.post(
      Uri.http("almasapps.ir", "wp-json/wp/v2/posts/"),
      headers: <String, String>{
        'Authorization': strAuth,
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'content': content,
        'status': 'publish'
      }));
  print("STATUS CODE : ${response.statusCode}");

  if (response.statusCode == 201) {
    print("STATUS CODE : ${response.statusCode}");
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed To Create Data");
  }
}

Future<Post> DeletePost(String id) async {
  String strAuth = "Basic bWFoZGk6TmVnaW4zNTI2ISE=";

  final response = await http.delete(
    Uri.http("almasapps.ir", "wp-json/wp/v2/posts/$id"),
    headers: <String, String>{
      'Authorization': strAuth,
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );
  print("STATUS CODE : ${response.statusCode}");

  if (response.statusCode == 200) {
    print("STATUS CODE : ${response.statusCode}");
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed To Delete Data");
  }
}



Future<Post> UpdatePost(String id,String title,String content) async {
  String strAuth = "Basic bWFoZGk6TmVnaW4zNTI2ISE=";

  final response = await http.put(
    Uri.http("almasapps.ir", "wp-json/wp/v2/posts/$id"),
    headers: <String, String>{
      'Authorization': strAuth,
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String,String>{
        'title' : title,
        'content' : content,
    })
  );
  print("STATUS CODE : ${response.statusCode}");

  if (response.statusCode == 200) {
    print("STATUS CODE : ${response.statusCode}");
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed To Update Data");
  }
}


