import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GeneratedPost {
  String content;
  final double score;

  GeneratedPost({required this.content, required this.score});

  factory GeneratedPost.fromList(List<dynamic> data) {
    return GeneratedPost(
      content: data[0] as String,
      score: (data[1] as num).toDouble(),
    );
  }
}

const String apiHost = String.fromEnvironment('API_HOST', defaultValue: 'localhost');
String getApiBaseUrl() {
  if(defaultTargetPlatform == TargetPlatform.android ||
     defaultTargetPlatform == TargetPlatform.iOS) {
    return 'http://10.0.2.2:8000';
  }
  return 'http://$apiHost:8000'; // FastAPI API
}

Future<List<GeneratedPost>> generatePost({
  required String userquery,
  required String tag,
  required String style,
  required int withindays,
  required int size,
  required int gclikes,
  required int recommendation,
  required String specific_user,
  http.Client? client,
}) async {
  final httpClient = client ?? http.Client();
  final url = Uri.parse('${getApiBaseUrl()}/generate'); // FastAPI API
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
      'recommendation': recommendation,
      'specific_user': specific_user,
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
    debugPrint('/generate 回傳內容: ${json}');
    List<dynamic> rawPosts = json['post'];
    return rawPosts
        .map((rp) => GeneratedPost.fromList((rp) as List<dynamic>))
        .toList();
  } else {
    throw Exception('API 錯誤：${json["error"]}');
  }

  // Close the client if we created it internally
}

Future<List<GeneratedPost>> generateSpecificUserPost({
  required String userquery,
  required String tag,
  required String style,
  required int withindays,
  required int size,
  required int gclikes,
  required int recommendation,
  required String specific_user,
  http.Client? client,
}) async {
  final httpClient = client ?? http.Client();
  final url = Uri.parse('${getApiBaseUrl()}/generate_specific_user'); // FastAPI API
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
      'recommendation': recommendation,
      'specific_user': specific_user,
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
    debugPrint('/generate_specific_user 回傳內容: ${json}');
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
  final url = Uri.parse('${getApiBaseUrl()}/tone'); // FastAPI API
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

// 文章風格
Future<List<String>> getTone({http.Client? client}) async {
  final httpClient = client ?? http.Client();
  final url = Uri.parse('${getApiBaseUrl()}/styles'); // FastAPI API
  final response = await httpClient.get(
    url,
    headers: {'Content-Type': 'application/json'},
  );
  final json = jsonDecode(response.body);
  if (response.statusCode != 200) {
    throw Exception('HTTP 錯誤：${response.statusCode}');
  }
  if (client == null) {
    httpClient.close(); // 只關閉自己建立的 client
  }
  if (json['success'] == true && json['styles'] is List) {
    return List<String>.from(json['styles']);
  } else {
    throw Exception('API 錯誤：${json["error"] ?? "未知錯誤"}');
  }
}

Future<bool> post({required String text, http.Client? client}) async {
  final httpClient = client ?? http.Client();
  final url = Uri.parse('${getApiBaseUrl()}/post'); // FastAPI API
  final response = await httpClient.post(
    url,
    body: jsonEncode({'text': text}),
    headers: {'Content-Type': 'application/json'},
  );
  final json = jsonDecode(response.body);
  if (response.statusCode != 200) {
    throw Exception('HTTP 錯誤：${response.statusCode}');
  }
  if (client == null) {
    httpClient.close(); // 只關閉自己建立的 client
  }
  return json['success'];
}

Future<bool> postWithSchedule({
  required String text,
  DateTime? time,
  http.Client? client,
}) async {
  final httpClient = client ?? http.Client();
  final url = Uri.parse('${getApiBaseUrl()}/post'); // FastAPI API
  Map<String, dynamic> body = {'text': text};
  if (time != null) {
    Map<String, dynamic> schedule = {
      'year': time.year,
      'month': time.month,
      'day': time.day,
      'hour': time.hour,
      'minute': time.minute,
    };
    body['schedule'] = schedule; // 添加排程時間
    // 寫入 Firestore
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('schedule').add({
        'content': text,
        'scheduledTime': Timestamp.fromDate(time),
        'userId': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
  // print json
  debugPrint('Post body: ${jsonEncode(body)}');
  final response = await httpClient.post(
    url,
    body: jsonEncode(body),
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

// 取得可用角色
Future<List<Map<String, dynamic>>> getAvailableTones({http.Client? client}) async {
  final httpClient = client ?? http.Client();
  final url = Uri.parse('${getApiBaseUrl()}/valid_tone'); // FastAPI API
  final response = await httpClient.get(
    url,
    headers: {'Content-Type': 'application/json'},
  );
  final json = jsonDecode(response.body);
  if (response.statusCode != 200) {
    throw Exception('HTTP 錯誤：${response.statusCode}');
  }
  if (client == null) {
    httpClient.close();
  }
  if (json['success'] == true) {
    final tones = List<Map<String, dynamic>>.from(json['tones']);
    return tones;
  } else {
    throw Exception('API 錯誤：${json["error"]}');
  }
}
