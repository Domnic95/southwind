import 'package:southwind/Models/Timer/timer_card.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';

class TimerCardNotifier extends BaseNotifier {
  UserData? userData;
  List<TimerCard> timerCardList = [];
  TimerCardNotifier() {
    userData = UserFetch().fetchUserData();
    notifyListeners();
  }
  Future timerHistroy() async {
    timerCardList.clear();
    final res = await dioClient.postWithFormData(apiEnd: api_timerHistory);
    timerCardList = List<TimerCard>.from(
        res.data["timecard_details"].map((x) => TimerCard.fromJson(x)));
  }
}
