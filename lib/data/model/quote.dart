class Quote {
  late String author;
  late String content;

  Quote.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    content = json['content'];
  }
}
