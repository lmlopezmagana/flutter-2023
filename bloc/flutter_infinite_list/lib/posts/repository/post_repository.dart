import 'package:flutter_infinite_list/posts/posts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:injectable/injectable.dart';


const _postLimit = 20;


@singleton
class PostRepository {

  final httpClient = http.Client();

  Future<List<Post>> fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;

      return List<Post>.from(
        //list.map((p) => Post.fromJson(p))
        body.map((p) => Post.fromJson(p))
      );
      
    }
    throw Exception('error fetching posts');
  }



}