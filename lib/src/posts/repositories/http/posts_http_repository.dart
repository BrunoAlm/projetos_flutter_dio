import 'package:first_proj_flutter_dio/src/posts/post_model.dart';
import 'package:first_proj_flutter_dio/src/posts/repositories/posts_repository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PostsHttpRepository implements PostsRepository {
  @override
  Future<List<PostModel>> getPosts() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      var jsonPosts = jsonDecode(response.body);
      return (jsonPosts as List).map((e) => PostModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
