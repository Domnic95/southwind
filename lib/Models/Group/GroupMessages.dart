// To parse this JSON data, do
//
//     final groupMessage = groupMessageFromJson(jsonString);

import 'dart:convert';

GroupMessage groupMessageFromJson(String str) =>
    GroupMessage.fromJson(json.decode(str));

String groupMessageToJson(GroupMessage data) => json.encode(data.toJson());

class GroupMessage {
  GroupMessage(
      {this.id,
      this.groupId,
      this.profileId,
      this.message,
      this.mediaUrl,
      this.mediaType,
      this.createdOn,
      this.userImage,
      this.fullName,
      this.today,
      this.displayTime});

  int? id;
  int? groupId;
  int? profileId;
  String? message;
  String? mediaUrl;
  MediaType? mediaType;
  DateTime? createdOn;
  String? userImage;
  String? fullName;
  String? today;
  String? displayTime;

  factory GroupMessage.fromJson(Map<String, dynamic> json) {
    DateTime date = DateTime.parse(json["created_on"]);

    return GroupMessage(
        id: json["id"],
        groupId: json["group_id"],
        profileId: json["profile_id"],
        message: json["message"],
        mediaUrl: json["media_url"],
        mediaType: media(json["media_type"].toString()),
        createdOn: DateTime.parse(json["created_on"]),
        userImage: json["user_image"],
        fullName: json["fullName"],
        today: json["today"],
        displayTime: timeDifference(date));
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "group_id": groupId,
        "profile_id": profileId,
        "message": message,
        "media_url": mediaUrl,
        "media_type": mediaType,
        "created_on": createdOn!.toIso8601String(),
        "user_image": userImage,
        "fullName": fullName,
        "today": today,
      };
}

enum MediaType { Image, Video, message }
MediaType media(String type) {
  if (type == 'video') {
    return MediaType.Video;
  } else if (type == 'image') {
    return MediaType.Image;
  } else {
    return MediaType.message;
  }
}

String timeDifference(DateTime times) {
  String time = '';
  DateTime now = DateTime.now();

  if (now.difference(times).inDays > 1) {
    time = "${times.day}/${times.month}/${times.year}";
  } else {
    String hour =
        times.hour > 13 ? (24 - times.hour).toString() : times.hour.toString();
    String ge = times.hour > 12 ? "pm" : "am";
    time = "${hour}:${times.minute} ${ge}";
  }
  return time;
}
