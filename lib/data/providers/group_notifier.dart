import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:southwind/Models/Group/GroupMember.dart';
import 'package:southwind/Models/Group/GroupMessages.dart';
import 'package:southwind/Models/Group/GroupModel.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';
import 'package:southwind/utils/File_Picker.dart';
import 'package:southwind/utils/cloudinaryclient/cloudinary_client.dart';
import 'package:southwind/utils/cloudinaryclient/models/CloudinaryResponse.dart';

class GroupNotifier extends BaseNotifier {
  UserData? userData;
  CloudinaryClient cloudinaryClient = CloudinaryClient();
  File_Picker file_picker = File_Picker();
  List<Group> listGroup = [];
  List<GroupMessage> listOfMessage = [];
  int? selectedGroupIndex;
  List<GroupMembers> listOfMembers = [];

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
      "group_id": listGroup[selectedGroupIndex!].groupId,
      'message': text,
      'media_url': "",
      'media_type': "",
    });
  }

  Future imageUpload(ImageSource source) async {
    String file = await file_picker.pickImage(source);

    CloudinaryResponse cloudinaryres = await cloudinaryClient.uploadImage(file,
        filename: "southDemoId", folder: 'Southwind');
    uploadMedia(cloudinaryres.url!, "image");
  }

  Future videoUpload(ImageSource source) async {
    String file = await file_picker.pickVideo(source);

    CloudinaryResponse cloudinaryres = await cloudinaryClient.uploadVideo(file,
        filename: "southDemoId", folder: 'Southwind');
    uploadMedia(cloudinaryres.url!, "video");
  }

  Future uploadMedia(String url, String media) async {
    final res =
        await dioClient.postWithFormData(apiEnd: api_sendMessage, data: {
      "group_id": listGroup[selectedGroupIndex!].groupId,
      'message': '',
      'media_url': url,
      'media_type': media,
    });
  }
}
