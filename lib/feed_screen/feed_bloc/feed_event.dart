part of 'feed_bloc.dart';

@immutable
sealed class FeedEvent {
  const FeedEvent();
}

class GetAllPosts extends FeedEvent {
  const GetAllPosts();
}

class RefreshFeed extends FeedEvent {
  const RefreshFeed();
}
