class Content{
  final String? rendered;
  final bool? protected;

  Content({this.rendered,this.protected});

  factory Content.fromJson(Map<String,dynamic> json){
    return Content(
      rendered: json["rendered"],
      protected: json["protected"]
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return removeAllHtmlTags(rendered!);
  }
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlText.replaceAll(exp, '');
}