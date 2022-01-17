import 'package:southwind/Models/learning/learning_notification.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';

class LearningNotifier extends BaseNotifier {
  UserData? userData;
  List<LearningNotification> learnings = [];
  LearningNotifier() {
    userData = UserFetch().fetchUserData();

    notifyListeners();
  }
  Future getLearning() async {
    learnings = [];
    final res = await dioClient.getRequest(apiEnd: api_learning_get);

    learnings = List<LearningNotification>.from(
        res.data["notifications"].map((x) => LearningNotification.fromJson(x)));
    // notifyListeners();
  }
}
