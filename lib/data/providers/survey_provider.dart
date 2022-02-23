import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:southwind/Models/survey/basic_survey_details.dart';
import 'package:southwind/Models/survey/individual_survey.dart';
import 'package:southwind/Models/survey/surveyModel.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';
import 'package:southwind/utils/helpers.dart';

class SurveyProvider extends BaseNotifier {
  UserData? userData;
  String selectedSurveyId = '';
  List<LibraryNotification> allSurvey = [];
  IndividualSurvey? selectedSurvey = IndividualSurvey();
  bool textReadibility = false;
  bool reloadData = false;
  List<IndividualSurvey> newSurvey = [];
  List<IndividualSurvey> submittedSurvey = [];
  SurveyProvider() {
    userData = UserFetch().fetchUserData();

    notifyListeners();
  }
  setSurveyId(int id) {
    selectedSurveyId = id.toString();
    notifyListeners();
  }

  setSurvey(IndividualSurvey survey) {
    selectedSurvey = survey;
    notifyListeners();
  }

  setReadibility(bool va) {
    textReadibility = va;

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
  reload() async {
    if(reloadData)
    await suveryNotification();
  }

  Future suveryNotification() async {
    allSurvey = [];
    newSurvey = [];
    submittedSurvey = [];
    final res = await dioClient.getRequest(apiEnd: api_getSurveyNotification);
    allSurvey = List<LibraryNotification>.from(
        res.data["notifications"].map((x) => LibraryNotification.fromJson(x)));
    for (int i = 0; i < allSurvey.length; i++) {
      final res = await dioClient.getRequest(
          apiEnd: api_getIndividualSurvey + allSurvey[i].id.toString());

      IndividualSurvey loc =
          IndividualSurvey.fromJson(res.data['notification']);
      if (loc.surveyNotificationQuestion!.length > 0) {
        if (loc.surveyNotificationQuestion!.first.surveyNotificationAnswer!
                .length >
            0) {
          submittedSurvey.add(loc);
        } else {
          newSurvey.add(loc);
        }
      } else {
        newSurvey.add(loc);
      }
    }
    reloadData = false;
    notifyListeners();
  }

  Future individualSurvey() async {
    final res = await dioClient.getRequest(
        apiEnd: api_getIndividualSurvey + selectedSurveyId);

    selectedSurvey = IndividualSurvey.fromJson(res.data['notification']);

    notifyListeners();
  }

  updateAnswer(int questionIndex, String notes, int option_id) {
    log("notres" + notes);
    selectedSurvey!.surveyAnswer![questionIndex].optionId = option_id;
    selectedSurvey!.surveyAnswer![questionIndex].other = notes;
    notifyListeners();
  }

  updateNotes(int questionIndex, String notes) {
    selectedSurvey!.surveyAnswer![questionIndex].other = notes;
    notifyListeners();
  }

  Future<bool> submitAnswers() async {
    final questionAnser = jsonEncode(selectedSurvey!.surveyAnswer!.map((e) {
      return e.toJson();
    }).toList());
    log('ressss = ${questionAnser}');
    final res = await dioClient.postWithFormData(
        apiEnd: api_submitSurveyAnswer,
        data: {
          "notification_id": selectedSurvey!.id,
          "answers": questionAnser
        });
    reloadData = true;
    notifyListeners();
    if (res != null) {
      return true;
    }
    return false;
  }
}


