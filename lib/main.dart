import 'package:feed/feed_screen/feed_bloc/feed_bloc.dart';
import 'package:feed/feed_screen/feed_screen.dart';
import 'package:feed/feed_screen/post_detail_screen/post_detail_screen.dart';
import 'package:feed/shared/blocs/posts/posts_bloc.dart';
import 'package:feed/shared/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'create_post_screen/create_post_screen.dart';
import 'shared/services/posts_data_source/fake_data_source.dart';
import 'shared/services/posts_repository/posts_repository.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostsRepository(
        postsDataSource: FakePostsDataSource(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FeedBloc(
              postsRepository: context.read<PostsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) =>
                PostsBloc(postsRepository: context.read<PostsRepository>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const HomeScreen(),
            '/createPost': (context) => const CreatePostScreen(),
          },
          onGenerateRoute: (routeSettings) {
            Widget screen = const Center(
              child: Text("404"),
            );
            final argument = routeSettings.arguments;
            switch (routeSettings.name) {
              case 'postDetail':
                if (argument is Post) {
                  screen = PostDetailScreen(post: argument);
                }
                break;
            }
            return MaterialPageRoute(builder: (context) => screen);
          },
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PostsBloc, PostsState>(
      listener: (context, state) {
        if (state.status == PostsStatus.success) {
          context.read<FeedBloc>().add(const RefreshFeed());
        }
      },
      child: Scaffold(
        body: const FeedScreen(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CreatePostScreen()),
            );
          },
          tooltip: 'Create new post',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
