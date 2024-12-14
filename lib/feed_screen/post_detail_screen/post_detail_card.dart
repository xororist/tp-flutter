import 'package:flutter/material.dart';
import '../../shared/models/post.dart';

class PostDetailCard extends StatelessWidget {
  final Post post;
  final VoidCallback showEditDialog;

  const PostDetailCard({
    super.key,
    required this.post,
    required this.showEditDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(post.title),
              subtitle: Text(post.description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: showEditDialog,
                  child: const Text('Edit'),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
