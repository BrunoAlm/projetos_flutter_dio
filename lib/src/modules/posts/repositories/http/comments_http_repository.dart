import 'package:first_proj_flutter_dio/src/modules/posts/comments/comment_model.dart';
import 'package:first_proj_flutter_dio/src/modules/posts/repositories/comments_repository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CommentsHttpRepository implements CommentsRepository {
  @override
  Future<List<CommentModel>> listComments(int postId) async {
    var response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/posts/$postId/comments"));
    if (response.statusCode == 200) {
      var jsonComments = jsonDecode(response.body);
      return (jsonComments as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
    }
    return [];
  }
}
