import 'package:flutter_rest_api_atividades/controller/fetchComments.dart';
import 'package:flutter_rest_api_atividades/model/comment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetchComments_test.mocks.dart';

@GenerateMocks([http.Client])
void main(){

  test('Retornar um comentário com sucesso', () async {
    final client = MockClient();

    when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/comments/2')))
    .thenAnswer((_) async => 
    http.Response('{"postId": 1, "id": 2, "name": "mock name", "email": "mock@email.com", "body": "mock body"}', 200));
    expect(await fetchComments(client), isA<Comments>());
  });

  test('Retornar um comentário com sucesso 2', () async {
    final client = MockClient();

    when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/comments/4')))
    .thenAnswer((_) async => 
    http.Response('{"postId": 5, "id": 4, "name": "mock name 3", "email": "mock3@email.com", "body": "mock3 body"}', 200));
    expect(await fetchComments(client), isA<Comments>());
  }); 

}