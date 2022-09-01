import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/comment.dart';

Future<Comments> fetchCommentsById(String id) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/comments/$id'));

  if (response.statusCode == 200) {
    return Comments.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load comments');
  }
}
