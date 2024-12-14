part of 'feed_bloc.dart';

enum FeedStatus { initial, loading, success, error }

class FeedState {
  final FeedStatus status;
  final List<Post> posts;
  final AppException? exception;

  const FeedState({
    this.status = FeedStatus.initial,
    this.posts = const [],
    this.exception,
  });

  FeedState copyWith({
    FeedStatus? status,
    List<Post>? posts,
    AppException? exception,
  }) {
    return FeedState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      exception: exception ?? this.exception,
    );
  }
}
