import 'Content.dart';
import 'Title.dart';

class Post{
  final int? id;
  final String? date;
  final Title? title;
  final Content? content;

  Post({this.id,this.date,this.title,this.content});

  factory Post.fromJson(Map<String,dynamic> json){
    return Post(
      id: json["id"],
      date: json["date"],
      title: Title.fromJson(json["title"]),
      content: Content.fromJson(json["content"])
    );
  }
}