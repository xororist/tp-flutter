part of 'posts_bloc.dart';

enum PostsStatus {
  initial,
  loading,
  success,
  error,
}

class PostsState {
  final PostsStatus status;
  final AppException? exception;

  const PostsState({
    this.status = PostsStatus.initial,
    this.exception,
  });

  PostsState copyWith({
    PostsStatus? status,
    AppException? exception,
  }) {
    return PostsState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
    );
  }
}
