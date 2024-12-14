import 'package:feed/shared/models/post.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

import 'posts_data_source.dart';

class FakePostsDataSource extends PostsDataSource {
  final log = Logger('FakeDataSource');

  final List<Post> _posts = [
    Post(
      id: const Uuid().v4(),
      title: 'Launch 🚀',
      description:
          'Just launched my new app! Check it out: https://example.com',
    ),
    Post(
      id: const Uuid().v4(),
      title: 'Developer Life 💻',
      description: 'The grind never stops. Coding all day. #DeveloperLife',
    ),
    Post(
      id: const Uuid().v4(),
      title: 'Learning Flutter 🔥',
      description: 'Learning something new today: Dart & Flutter!',
    ),
    Post(
      id: const Uuid().v4(),
      title: 'Unexpected 😅',
      description: 'You won\'t believe what happened today. Stay tuned!',
    ),
    Post(
      id: const Uuid().v4(),
      title: 'Tutorial Suggestions',
      description: 'Any recommendations for a good Dart/Flutter tutorial?',
    ),
    Post(
      id: const Uuid().v4(),
      title: 'Productive Day 💪',
      description:
          'Feeling productive today. Fixed 5 bugs and added 3 features.',
    ),
    Post(
      id: const Uuid().v4(),
      title: 'Take a Break 🧘‍♂️',
      description:
          'This is your friendly reminder to take a break and stretch!',
    ),
    Post(
      id: const Uuid().v4(),
      title: 'Favorite Widgets',
      description: 'What\'s your favorite Flutter widget? Mine is ListView!',
    ),
    Post(
      id: const Uuid().v4(),
      title: 'Motivation 🌊',
      description: 'A smooth sea never made a skilled sailor. #Motivation',
    ),
    Post(
      id: const Uuid().v4(),
      title: 'Side Project 👨‍💻',
      description: 'Working on a new side project. Excited to share more soon!',
    ),
  ];

  @override
  Future<List<Post>> getAllPosts() async {
    log.info('Feed requested');
    await Future.delayed(const Duration(milliseconds: 500));
    log.info('Feed loaded');
    return List.from(_posts.reversed);
  }

  @override
  Future<void> createPost(Post post) async {
    await Future.delayed(const Duration(milliseconds: 500));
    log.info('Post created $post');
    _posts.add(post);
  }

  @override
  Future<void> updatePost(String id, Post updatedPost) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final postIndex = _posts.indexWhere((p) => p.id == id);
    if (postIndex != -1) {
      _posts[postIndex] = updatedPost;
      log.info('Post updated: $updatedPost');
    } else {
      log.warning('Post with ID $id not found.');
    }
  }
}
