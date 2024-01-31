import 'package:first_proj_flutter_dio/src/posts/comments/comments_page.dart';
import 'package:first_proj_flutter_dio/src/posts/post_model.dart';
import 'package:first_proj_flutter_dio/src/posts/repositories/dio/posts_dio_repository.dart';
import 'package:first_proj_flutter_dio/src/posts/repositories/posts_repository.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatefulWidget {
  final String title;
  const PostsPage({super.key, required this.title});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late PostsRepository postsRepository;

  var posts = <PostModel>[];

  @override
  void initState() {
    super.initState();
    postsRepository = PostsDioRepository();
    loadPosts();
  }

  loadPosts() async {
    posts = await postsRepository.getPosts();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (_, index) {
          var post = posts[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommentsPage(postId: post.id),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      post.body,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
