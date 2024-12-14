import 'package:bloc/bloc.dart';
import 'package:feed/shared/services/posts_repository/posts_repository.dart';
import 'package:flutter/material.dart';
import '../../shared/exceptions/app_exception.dart';
import '../../shared/models/post.dart';

part 'feed_event.dart';

part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PostsRepository postsRepository;

  FeedBloc({required this.postsRepository}) : super(const FeedState()) {
    on<GetAllPosts>((event, emit) async {
      emit(state.copyWith(status: FeedStatus.loading));
      try {
        final posts = await postsRepository.getAllPosts();
        emit(state.copyWith(
          posts: posts,
          status: FeedStatus.success,
        ));
      } catch (error) {
        emit(state.copyWith(
          status: FeedStatus.error,
          exception: AppException.from(error),
        ));
      }
    });

    on<RefreshFeed>((event, emit) async {
      emit(state.copyWith(status: FeedStatus.loading));
      try {
        final posts = await postsRepository.getAllPosts();
        emit(state.copyWith(
          posts: posts,
          status: FeedStatus.success,
        ));
      } catch (error) {
        emit(state.copyWith(
          status: FeedStatus.error,
          exception: AppException.from(error),
        ));
      }
    });
  }
}
