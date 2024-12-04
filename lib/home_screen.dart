import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'post_provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Search Books')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter book title or author',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    postProvider.fetchBooks(_controller.text);
                  },
                ),
              ),
            ),
          ),
          if (postProvider.isLoading)
            Center(child: CircularProgressIndicator())
          else if (postProvider.isOffline)
            Center(child: Text('You are offline, displaying cached books'))
          else if (postProvider.posts.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: postProvider.posts.length,
                itemBuilder: (context, index) {
                  final post = postProvider.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.author),
                  );
                },
              ),
            )
          else
            Center(child: Text('No books found')),
        ],
      ),
    );
  }
}
