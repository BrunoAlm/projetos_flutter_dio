import 'package:projetos_flutter_dio/src/modules/posts/comments/comment_model.dart';

abstract class CommentsRepository {
  Future<List<CommentModel>> listComments(int postId);
}
