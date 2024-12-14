import 'package:bloc/bloc.dart';
import 'package:feed/shared/services/posts_repository/posts_repository.dart';
import 'package:flutter/material.dart';

import '../../exceptions/app_exception.dart';
import '../../models/post.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository postsRepository;

  PostsBloc({required this.postsRepository})
      : super(const PostsState()) {
    on<CreatePost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));
      try {
        await postsRepository.createPost(event.post);
        emit(state.copyWith(status: PostsStatus.success));
        event.onSuccess?.call();
      } catch (error) {
        emit(state.copyWith(
          status: PostsStatus.error,
          exception: AppException.from(error),
        ));
      }
    });

    on<UpdatePost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));

      try {
        await postsRepository.updatePost(
            event.id, event.updatedPost);
        emit(state.copyWith(status: PostsStatus.success));
      } catch (error) {
        emit(state.copyWith(
          status: PostsStatus.error,
          exception: AppException.from(error),
        ));
      }
    });
  }
}
