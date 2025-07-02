import 'package:flutter/material.dart';
import '../models/comment.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  PostDetailPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Post")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(post.body),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.favorite_border),
                    Icon(Icons.comment_outlined),
                    Icon(Icons.share_outlined),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("Most Relevant", style: TextStyle(color: Colors.grey)),
          ),
          // Dummy comments list
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${index + 10}'),
                  ),
                  title: Text("User ${index + 1}"),
                  subtitle: Text("This is a comment."),
                );
              },
            ),
          ),
          // Comment input at the bottom
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=20'),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Add a comment...",
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      suffixIcon: Icon(Icons.photo, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
