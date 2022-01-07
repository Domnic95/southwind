import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:southwind/Models/news/singleNews.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';

class NewsNotifier extends BaseNotifier {
  List<SingleNews> total_news = [];
  UserData? userData;
  NewsNotifier() {
    userData = UserFetch().fetchUserData();

    notifyListeners();
  }
  Future fetchNews() async {
    total_news = [];

    Response res = await dioClient.postWithFormData(apiEnd: api_getNews, data: {
      'team_id': userData!.teamId,
      'client_id': userData!.id,
      'total_chat': 0,
      'is_admin': userData!.isAdmin,
      'selected_additional_team_id': userData!.additionalTeamId
    });

    total_news = List<SingleNews>.from(
        res.data["CommNotification"].map((x) => SingleNews.fromJson(x)));

    // if (res.data.containsKey('CommNotification'))
    //   total_news = List<SingleNews>.from(
    //       res.data["CommNotification"].map((x) => SingleNews.fromJson(x)));

    // notifyListeners();
  }

  like(int index) async {
    final res = await dioClient.postWithFormData(
        apiEnd: api_newsLike, data: {"notification_id": total_news[index].id});
 
    if (res.data['isSuccess']) {
      total_news[index].liked = true;
      total_news[index].likes = total_news[index].likes! + 1;
    }
    notifyListeners();
  }

  dislike(int index) async {
    final res = await dioClient.postWithFormData(
        apiEnd: api_newsDislike,
        data: {"notification_id": total_news[index].id});
   
    if (res.data['isSuccess']) {
      total_news[index].liked = false;
      total_news[index].likes = total_news[index].likes! - 1;
    }
    notifyListeners();
  }
}
