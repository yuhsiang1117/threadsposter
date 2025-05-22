
class PostQuery {
  String userQuery;
  String tag;
  String style;
  int withInDays;
  int size;
  int gclikes;
  int returnCount;
  String tone;

  PostQuery({
    required this.userQuery,
    required this.tag,
    required this.style,
    required this.withInDays,
    required this.size,
    required this.gclikes,
    required this.returnCount,
    required this.tone,
  });

  @override
  String toString() {
    return 'PostQuery(userQuery: $userQuery, tag: $tag, style: $style, withInDays: $withInDays, size: $size, gclikes: $gclikes, returnCount: $returnCount, tone: $tone)';
  }
  Map<String, dynamic> toJson() {
    return {
      'userQuery': userQuery,
      'tag': tag,
      'style': style,
      'withInDays': withInDays,
      'size': size,
      'gclikes': gclikes,
      'returnCount': returnCount,
      'tone': tone,
    };
  }
}