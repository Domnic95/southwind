import 'dart:developer';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:southwind/Models/Group/GroupMember.dart';
import 'package:southwind/Models/Group/GroupMessages.dart';
import 'package:southwind/Models/Group/GroupModel.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';

class GroupNotifier extends BaseNotifier {
  UserData? userData;

  List<Group> listGroup = [];
  List<GroupMessage> listOfMessage = [];
  int? selectedGroupIndex;
  List<GroupMembers> listOfMembers = [];
final cloudinary = CloudinaryPublic('CLOUD_NAME', 'UPLOAD_PRESET', cache: false,);
  GroupNotifier() {
    userData = UserFetch().fetchUserData();

    notifyListeners();
  }
  setGroupId(int id) {
    this.selectedGroupIndex = id;
    listOfMessage = [];
    listOfMembers = [];
    notifyListeners();
  }

  Future getAllGroup() async {
    listGroup = [];
    final res = await dioClient.postWithFormData(apiEnd: api_group_list);
    listGroup =
        List<Group>.from(res.data['groupsList'].map((e) => Group.fromJson(e)));
    notifyListeners();
  }

  Future getIndividualGroupMessages() async {
    final res =
        await dioClient.postWithFormData(apiEnd: api_get_group_msgs, data: {
      "total_chat": 0, // static at a time
      "group_id": listGroup[selectedGroupIndex!].groupId
    });
    log("messgae = ${res}");
    listOfMessage = List<GroupMessage>.from(
        res.data['groupMessages'].map((x) => GroupMessage.fromJson(x)));
    log("messgae = ${listOfMessage.length}");
    notifyListeners();
  }

  Future getGroupMembers() async {
    final res = await dioClient.postWithFormData(
        apiEnd: api_getGroup_participates,
        data: {"group_id": listGroup[selectedGroupIndex!].groupId});

    listOfMembers = List<GroupMembers>.from(
        res.data['groupMembers'].map((x) => GroupMembers.fromJson(x)));

    notifyListeners();
  }

  Future sendMessage(String text) async {
    final res =
        await dioClient.postWithFormData(apiEnd: api_sendMessage, data: {
      "group_id": 1,
      'message': text,
      'media_url': "",
      'media_type': "",
    });
  }
}
