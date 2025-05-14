import 'package:http/http.dart' as http;
import 'dart:convert';

class GeneratedPost {
  final String content;
  final double score;

  GeneratedPost({required this.content, required this.score});

  factory GeneratedPost.fromList(List<dynamic> data) {
    return GeneratedPost(
      content: data[0] as String,
      score: (data[1] as num).toDouble(),
    );
  }
}

Future<List<GeneratedPost>> generatePost({
  required String userquery,
  required String tag,
  required String style,
  required int withindays,
  required int size,
  required int gclikes,
  required int topK,
  http.Client? client,
}) async {
  final httpClient = client ?? http.Client();
  final url = Uri.parse('http://localhost:8000/generate'); // FastAPI API
  final response = await httpClient.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'userquery': userquery,
      'style': style,
      'tag': tag,
      'size': size,
      'withindays': withindays,
      'gclikes': gclikes,
      'top_k': topK,
    }),
  );
  final json = jsonDecode(response.body);
  if (response.statusCode != 200) {
    throw Exception('HTTP 錯誤：${response.statusCode}');
  }
  if (client == null) {
    httpClient.close();
  }
  if (json['success'] == true) {
    List<dynamic> rawPosts = json['post'];
    return rawPosts
        .map((rp) => GeneratedPost.fromList((rp) as List<dynamic>))
        .toList();
  } else {
    throw Exception('API 錯誤：${json["error"]}');
  }

  // Close the client if we created it internally
}

Future<bool> changeTone({required String tone, http.Client? client}) async {
  final httpClient = client ?? http.Client();
  final url = Uri.parse('http://localhost:8000/tone'); // FastAPI API
  final response = await httpClient.post(
    url,
    body: jsonEncode({'tone': tone}),
    headers: {'Content-Type': 'application/json'},
  );
  final json = jsonDecode(response.body);
  if (response.statusCode != 200) {
    throw Exception('HTTP 錯誤：${response.statusCode}');
  }
  if (client == null) {
    httpClient.close();
  }
  return json['success'];
}
