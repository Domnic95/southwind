import 'package:southwind/Models/career/careerModel.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';

class CareerProvider extends BaseNotifier {
  UserData? userData;
  CareerModel careerModel = CareerModel();
  List<CareerPath> dropDownCareerPath = [];
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
  }
}
