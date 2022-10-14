class Title{
  final String? rendered;

  Title({this.rendered});

  factory Title.fromJson(Map<String,dynamic> json){
    return Title(
      rendered: json["rendered"]
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