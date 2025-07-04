import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';
import 'post_detail_page.dart';

class PostListPage extends StatelessWidget {
  final PostController controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: SizedBox(),
        title: Text(
          "Threads",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.error.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.error.value, textAlign: TextAlign.center),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => controller.fetchPosts(),
                  child: Text("Retry"),
                )
              ],
            ),
          );
        } else if (controller.posts.isEmpty) {
          return Center(child: Text("No posts found"));
        } else {
          return ListView.builder(
            itemCount: controller.posts.length,
            itemBuilder: (_, index) => buildPostCard(controller.posts[index]),
          );
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }

  Widget buildPostCard(post) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${post.userId + 3}'),
        ),
        title: Text(post.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(post.body.length > 80 ? "${post.body.substring(0, 80)}..." : post.body),
            SizedBox(height: 4),
            Text("2d ago", style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        onTap: () {
          Get.to(() => PostDetailPage(post: post));
        },
      ),
    );
  }
}
