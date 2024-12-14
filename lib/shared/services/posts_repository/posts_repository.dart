import 'package:logging/logging.dart';

import '../../models/post.dart';
import '../posts_data_source/posts_data_source.dart';

class PostsRepository {
  final PostsDataSource postsDataSource;
  final log = Logger('PostsRepository');

  PostsRepository({
    required this.postsDataSource,
  });

  Future<List<Post>> getAllPosts() async {
    try {
      final products = await postsDataSource.getAllPosts();
      return products;
    } catch (error) {
      log.warning(error);
      throw Exception(error.toString());
    }
  }

  Future<void> createPost(Post post) async {
    postsDataSource.createPost(post);
    log.info('Post created $post');
  }

  Future<void> updatePost(
      String id, Post updatedPost) async {
    try {
      await postsDataSource.updatePost(id, updatedPost);
      log.info('Post updated $updatedPost');
    } catch (error) {
      log.warning(error);
    }
  }
}
