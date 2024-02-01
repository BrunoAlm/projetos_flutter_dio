import 'package:first_proj_flutter_dio/src/modules/posts/post_model.dart';

abstract class PostsRepository {
  Future<List<PostModel>> getPosts();
}
