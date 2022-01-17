import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:southwind/Models/survey/basic_survey_details.dart';
import 'package:southwind/Models/survey/individual_survey.dart';
import 'package:southwind/Models/survey/surveyModel.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';

class SurveyProvider extends BaseNotifier {
  UserData? userData;
  String selectedSurveyId = '';
  List<LibraryNotification> allSurvey = [];
  SurveyProvider() {
    userData = UserFetch().fetchUserData();

    notifyListeners();
  }
  setSurveyId(int id) {
    selectedSurveyId = id.toString();
    notifyListeners();
  }

  // Future getallSurvey() async {
  //   final res = await dioClient.postWithFormData(apiEnd: api_getSurvey, data: {
  //     'selected_additional_team_id': 2,
  //     'team_id': userData?.teamId,
  //     'is_admin': userData?.isAdmin,
  //     'notification_type': 'survey'
  //   });

  //   allSurvey = List<BasicSurveyDetail>.from(res.data['profile_details']
  //           ['survey']
  //       .map((x) => BasicSurveyDetail.fromJson(x)));
  // }
  Future suveryNotification() async {
    allSurvey = [];
    final res = await dioClient.getRequest(apiEnd: api_getSurveyNotification);
    allSurvey = List<LibraryNotification>.from(
        res.data["notifications"].map((x) => LibraryNotification.fromJson(x)));
    notifyListeners();
  }

  Future<IndividualSurvey> individualSurvey() async {
    final res = await dioClient.getRequest(
        apiEnd: api_getIndividualSurvey + selectedSurveyId);
    return IndividualSurvey.fromJson(res);
  }
}
