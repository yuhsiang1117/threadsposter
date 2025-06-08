class ArticleQuery {
  String text;
  String time;

  ArticleQuery({
    required this.text,
    required this.time,
  });

  @override
  String toString() {
    return 'ArticleQuery(text: $text, time: $time)';
  }
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'time': time,
    };
  }
}