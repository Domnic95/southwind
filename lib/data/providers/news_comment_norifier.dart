import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:southwind/Models/news/comment_modal.dart';
import 'package:southwind/data/providers/base_notifer.dart';

class NewsCommentNotifier extends BaseNotifier {
  String notificationId = "";
  bool isLoading = true;
  List<CommentModal> comments = [];
  NewsCommentNotifier(this.notificationId) {
    loadComments();
  }
  loadComments() async {
    Response res = await dioClient.postWithFormData(
      apiEnd: apiCommentList,
      data: {
        'notification_id': notificationId,
      },
    );
    log(res.data.toString());
    if (res.statusCode == 200) {
      comments = List<CommentModal>.from(
          res.data["comments"].map((x) => CommentModal.fromJson(x)));
    }
    isLoading = false;
    if (hasListeners) notifyListeners();
  }
}
