class Post {
  final String id;
  final String title;
  final String description;

  const Post({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  String toString() {
    return 'Post{id: $id, title: $title, content: $description}';
  }
}
