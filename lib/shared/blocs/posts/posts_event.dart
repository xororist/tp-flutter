part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {
  const PostsEvent();
}

class CreatePost extends PostsEvent {
  final Post post;
  final VoidCallback? onSuccess;

  const CreatePost(this.post, {this.onSuccess});
}

class UpdatePost extends PostsEvent {
  final String id;
  final Post updatedPost;
  final VoidCallback? onSuccess;

  const UpdatePost(this.id, this.updatedPost, {this.onSuccess});
}
