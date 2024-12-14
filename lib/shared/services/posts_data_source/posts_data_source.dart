import '../../models/post.dart';

abstract class PostsDataSource {
  Future<List<Post>> getAllPosts();

  Future<void> createPost(Post post);

  Future<void> updatePost(String id, Post updatedPost);
}
