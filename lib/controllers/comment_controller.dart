import 'package:get/get.dart';
import '../models/comment.dart';
import '../services/api_service.dart';

class CommentController extends GetxController {
  final int postId;
  CommentController(this.postId);

  var comments = <Comment>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchComments();
  }

  void fetchComments() async {
    try {
      isLoading(true);
      comments.value = await ApiService.fetchComments(postId);
    } catch (e) {
      // fallback to dummy comments
      comments.value = List.generate(5, (index) => Comment(
          id: index,
          name: "User ${index + 1}",
          email: "user${index + 1}@example.com",
          body: "This is a comment."
      ));
    } finally {
      isLoading(false);
    }
  }
}
