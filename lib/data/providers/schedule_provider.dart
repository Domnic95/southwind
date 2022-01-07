import 'package:flutter/cupertino.dart';
import 'package:southwind/Models/schedule/schedule_model.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';
import 'package:southwind/utils/helpers.dart';

class ScheduleProvider extends BaseNotifier {
  UserData? userData;
  ScheduleModel scheduleModel = ScheduleModel();
  List<DateTime> schedule_dates = [];
  List<DateTime> leaveDays_dates = [];

  ScheduleProvider() {
    userData = UserFetch().fetchUserData();

    // initialize();
    notifyListeners();
  }
  // initialize() async {
  //   await getScheduleData();
  // }

  getScheduleData() async {
    // scheduleModel.profileSchedules!.clear();
    // scheduleModel.profileTimeOff!.clear();

    schedule_dates = [];
    final res = await dioClient.getRequest(apiEnd: api_schedule);
    print(res);
    scheduleModel = ScheduleModel.fromJson(res.data['result']);
    for (int i = 0; i < scheduleModel.profileSchedules!.length; i++) {
      schedule_dates.add(scheduleModel.profileSchedules![i].day!);
    }

    notifyListeners();
  }

  Future<List<int>> getSchedule(DateTime dateTime) async {
    List<int> scheduleIndex = [];

    for (int i = 0; i < scheduleModel.profileSchedules!.length; i++) {
      if (scheduleModel.profileSchedules![i].day == dateTime) {
        print(scheduleModel.profileSchedules![i].day);
        print(i);
        scheduleIndex.add(i);
      }
    }
    return scheduleIndex;
  }

  Future request(
      {required DateTime time,
      required String reason,
      required BuildContext context}) async {
    String date =
        time.year.toString() + time.month.toString() + time.day.toString();
    final res = await dioClient
        .postWithFormData(apiEnd: api_set_time_off_request, data: {
      'team_id': userData!.teamId,
      'req_message': reason,
      'off_date': date,
    });
    showToast(res.data['message']);
  }
}
