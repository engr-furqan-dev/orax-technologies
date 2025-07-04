import 'package:get/get.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class PostController extends GetxController {
  var posts = <Post>[].obs;
  var isLoading = true.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      posts.value = await ApiService.fetchPosts();
      error('');
    } catch (e) {
      error('Failed to load posts');
    } finally {
      isLoading(false);
    }
  }
}
