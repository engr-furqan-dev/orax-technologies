import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/post.dart';
import '../controllers/comment_controller.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  PostDetailPage({required this.post});

  @override
  Widget build(BuildContext context) {
    final commentController = Get.put(CommentController(post.id));

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
          Expanded(
            child: Obx(() {
              if (commentController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (commentController.comments.isEmpty) {
                return Center(child: Text("No comments found"));
              } else {
                return ListView.builder(
                  itemCount: commentController.comments.length,
                  padding: EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final comment = commentController.comments[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${index + 10}'),
                      ),
                      title: Text(comment.name),
                      subtitle: Text(comment.body),
                    );
                  },
                );
              }
            }),
          ),

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
