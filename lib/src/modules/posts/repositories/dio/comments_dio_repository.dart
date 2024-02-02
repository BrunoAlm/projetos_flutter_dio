import 'package:projetos_flutter_dio/src/modules/posts/comments/comment_model.dart';
import 'package:projetos_flutter_dio/src/modules/posts/repositories/comments_repository.dart';
import 'package:dio/dio.dart';

class CommentsDioRepository implements CommentsRepository {
  @override
  Future<List<CommentModel>> listComments(int postId) async {
    var dio = Dio();
    var response = await dio
        .get("https://jsonplaceholder.typicode.com/posts/$postId/comments");
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
    }
    return [];
  }
}
