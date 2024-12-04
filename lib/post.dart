import 'package:hive/hive.dart';



@HiveType(typeId: 0)
class Post {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String author;

  Post({required this.title, required this.author});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title_suggest'] ?? 'No title available',
      author: json['author_name'] != null && json['author_name'].isNotEmpty
          ? json['author_name'][0]
          : 'No author available',
    );
  }
}
