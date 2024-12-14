import 'package:feed/feed_screen/post_detail_screen/post_detail_card.dart';
import 'package:feed/shared/widgets/post_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/post.dart';
import '../../shared/blocs/posts/posts_bloc.dart';

class PostDetailScreen extends StatefulWidget {
  static Future<void> navigateTo(
      BuildContext context, Post post) {
    return Navigator.pushNamed(context, 'postDetail',
        arguments: post);
  }

  const PostDetailScreen({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<PostDetailScreen> createState() =>
      _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late Post currentPost;

  @override
  void initState() {
    super.initState();
    currentPost = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostsBloc, PostsState>(
      listener: (context, state) {
        if (state.status == PostsStatus.success) {
          final updatedPost = currentPost;

          setState(() {
            currentPost = updatedPost;
          });

          Navigator.of(context).pop();
        } else if (state.status == PostsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to update the post.")),
          );
        }
      },
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state.status == PostsStatus.loading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return PostDetailCard(
            post: currentPost,
            showEditDialog: () => _showEditDialog(context, currentPost),
          );
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, Post postToUpdate) {
    final TextEditingController titleController =
        TextEditingController(text: postToUpdate.title);
    final TextEditingController contentController =
        TextEditingController(text: postToUpdate.description);

    showDialog(
      context: context,
      builder: (context) {
        return PostDialog(
          titleController: titleController,
          contentController: contentController,
          action: () {
            final updatedPost = Post(
              id: postToUpdate.id,
              title: titleController.text.trim(),
              description: contentController.text.trim(),
            );
            _updatePost(context, updatedPost);
          },
        );
      },
    );
  }

  void _updatePost(
      BuildContext context, Post updatedPost) {
    context
        .read<PostsBloc>()
        .add(UpdatePost(updatedPost.id, updatedPost));
  }
}
