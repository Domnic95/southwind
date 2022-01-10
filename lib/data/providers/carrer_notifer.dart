import 'dart:convert';
import 'dart:developer';

import 'package:southwind/Models/career/careerModel.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';

class CareerProvider extends BaseNotifier {
  UserData? userData;
  CareerModel careerModel = CareerModel();
  // carre path
  List<CareerPath> dropDownCareerPath = [];
  CareerPath selectedCareerPath = CareerPath();
  int selectedCareerPathIndex = 0;
  // achievement
  List<CareerAchievement> newAchievement = [];
  List<CareerAchievement> submittedAchievement = [];
  List<CareerAchievement> completedAchievement = [];
  CareerAchievement selectedAchievement = CareerAchievement();

  CareerProvider() {
    userData = UserFetch().fetchUserData();
    notifyListeners();
  }
  Future getCareerQuestion() async {
    careerModel = CareerModel();
    final res = await dioClient.postWithFormData(apiEnd: api_career, data: {
      'team_id': userData!.teamId,
      'total_chat': 0,
      'is_admin': userData!.adminUserId,
      // 'logProfile': "",
      // 'franchiseuser_detail': "",
      // 'questions': "",
    });

    careerModel = CareerModel.fromJson(res.data['data']);
    await categorizedData();
    notifyListeners();
  }

  Future categorizedData() async {
    // dropDown data
    dropDownCareerPath.clear();

    for (int i = 0; i < careerModel.careerPath!.length; i++) {
      if (careerModel.careerId!.contains(careerModel.careerPath![i].id)) {
        dropDownCareerPath.add(careerModel.careerPath![i]);
      }
    }
    if (dropDownCareerPath.isNotEmpty) {
      selectedCareerPath = dropDownCareerPath.first;
      getAchievementWisely();
    }
  }

  setIndexAndPath(CareerPath careerPath, int index) {
    selectedCareerPath = careerPath;
    selectedCareerPathIndex = index;
    getAchievementWisely();
    notifyListeners();
  }

  getAchievementWisely() {
    newAchievement = [];
    submittedAchievement = [];
    completedAchievement = [];
    String _careerId = selectedCareerPath.id.toString();
    for (int i = 0;
        i < careerModel.careerAchievements![_careerId]!.length;
        i++) {
      if (careerModel.careerAchievements![_careerId]![i].submitStatus == '0') {
        newAchievement.add(careerModel.careerAchievements![_careerId]![i]);
      } else if (careerModel.careerAchievements![_careerId]![i].submitStatus ==
          '1') {
        submittedAchievement
            .add(careerModel.careerAchievements![_careerId]![i]);
      } else {
        completedAchievement
            .add(careerModel.careerAchievements![_careerId]![i]);
      }
    }
  }

  setAchievement(CareerAchievement careerAchievement) {
    selectedAchievement = careerAchievement;
    notifyListeners();
  }

  updateAnswer(int index, String answer) {
    careerModel
        .questions![selectedCareerPath.id.toString()]![
            selectedAchievement.id.toString()]![index]
        .answer = answer;

    notifyListeners();
  }

  Future<bool> submitAnswers() async {
    final questionAnser = jsonEncode(careerModel
        .questions![selectedCareerPath.id.toString()]![
            selectedAchievement.id.toString()]!
        .map((e) {
      return e.toJson();
    }).toList());
    log(questionAnser.toString());
    final res = await dioClient
        .postWithFormData(apiEnd: api_career_submit_answer, data: {
      "achievement_id": selectedAchievement.id.toString(),
      "team_id": userData!.teamId.toString(),
      "client_id": userData!.id.toString(),
      "is_admin": userData!.isAdmin.toString(),
      'career_id': selectedCareerPath.id.toString(),
      'submit_status': '1',
      'questions': questionAnser
    });
    if (res != null) {
      return true;
    }

    log("response ====" + res.toString());
    return false;
  }
}
