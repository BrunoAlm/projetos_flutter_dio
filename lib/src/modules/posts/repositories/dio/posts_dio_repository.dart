import 'package:projetos_flutter_dio/src/modules/posts/post_model.dart';
import 'package:projetos_flutter_dio/src/modules/posts/repositories/posts_repository.dart';
import 'package:dio/dio.dart';

class PostsDioRepository implements PostsRepository {
  @override
  Future<List<PostModel>> getPosts() async {
    var dio = Dio();
    var response = await dio.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
