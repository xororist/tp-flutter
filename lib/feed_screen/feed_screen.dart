import 'package:feed/feed_screen/post_detail_screen/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/exceptions/app_exception.dart';
import '../shared/models/post.dart';
import 'feed_bloc/feed_bloc.dart';
import 'widgets/post_list_item.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    _getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          return switch (state.status) {
            FeedStatus.initial || FeedStatus.loading => _buildLoading(context),
            FeedStatus.error => _buildError(context, state.exception),
            FeedStatus.success => _buildSuccess(context, state.posts),
          };
        },
      ),
    );
  }

  void _getAllPosts() {
    final postsBloc = BlocProvider.of<FeedBloc>(context);
    postsBloc.add(const GetAllPosts());
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(BuildContext context, AppException? exception) {
    return Center(
      child: Text('[ERROR]: $exception'),
    );
  }

  Widget _buildSuccess(BuildContext context, List<Post> pubications) {
    return RefreshIndicator(
      onRefresh: () async => _getAllPosts(),
      child: ListView.separated(
        itemCount: pubications.length,
        separatorBuilder: (context, index) => const SizedBox(),
        itemBuilder: (context, index) {
          if (index >= pubications.length) {
            return const SizedBox();
          }
          final post = pubications[index];
          return PostsListItem(
            post: post,
            onTap: () => _openPostDetailScreen(context, post),
          );
        },
      ),
    );
  }

  void _openPostDetailScreen(BuildContext context, Post post) {
    PostDetailScreen.navigateTo(context, post);
  }
}
