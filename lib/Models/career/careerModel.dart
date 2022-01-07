import 'dart:convert';

class CareerModel {
  CareerModel({
    this.careerPath,
    this.careerId,
    this.careerAchievements,
    this.questions,
    this.countArray,
    this.mycount,
  });

  List<CareerPath>? careerPath;
  List<int>? careerId;
  Map<String, List<CareerAchievement>>? careerAchievements;
  Map<String, Map<String, List<Question>>>? questions;
  Map<String, CountArray>? countArray;
  Map<String, Mycount>? mycount;

  factory CareerModel.fromJson(Map<String, dynamic> json) => CareerModel(
        careerPath: List<CareerPath>.from(
            json["career_path"].map((x) => CareerPath.fromJson(x))),
        careerId: List<int>.from(json["career_id"].map((x) => x)),
        careerAchievements: Map.from(json["career_achievements"]).map((k, v) =>
            MapEntry<String, List<CareerAchievement>>(
                k,
                List<CareerAchievement>.from(
                    v.map((x) => CareerAchievement.fromJson(x))))),
        questions: Map.from(json["questions"]).map((k, v) =>
            MapEntry<String, Map<String, List<Question>>>(
                k,
                Map.from(v).map((k, v) => MapEntry<String, List<Question>>(k,
                    List<Question>.from(v.map((x) => Question.fromJson(x))))))),
        countArray: Map.from(json["countArray"]).map(
            (k, v) => MapEntry<String, CountArray>(k, CountArray.fromJson(v))),
        mycount: Map.from(json["mycount"])
            .map((k, v) => MapEntry<String, Mycount>(k, Mycount.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "career_path": List<dynamic>.from(careerPath!.map((x) => x.toJson())),
        "career_id": List<dynamic>.from(careerId!.map((x) => x)),
        "career_achievements": Map.from(careerAchievements!).map((k, v) =>
            MapEntry<String, dynamic>(
                k, List<dynamic>.from(v.map((x) => x.toJson())))),
        "questions": Map.from(questions!).map((k, v) =>
            MapEntry<String, dynamic>(
                k,
                Map.from(v).map((k, v) => MapEntry<String, dynamic>(
                    k, List<dynamic>.from(v.map((x) => x.toJson())))))),
        "countArray": Map.from(countArray!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "mycount": Map.from(mycount!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class CareerAchievement {
  CareerAchievement({
    this.id,
    this.careerId,
    this.achievements,
    this.achievementType,
    this.achievementDesc,
    this.attachmentUrl,
    this.isResourceLibrary,
    this.resourceLibraryId,
    this.cloudinaryId,
    this.cloudinaryUrl,
    this.cloudinarySecureUrl,
    this.createdBy,
    this.adminUserId,
    this.lastModified,
    this.position,
    this.resourceType,
    this.teamId,
    this.resourceVideoLink,
    this.cloudinaryAudioSecureUrl,
    this.feedback,
    this.achived,
    this.submitStatus,
    this.newCreatedOn,
  });

  int? id;
  int? careerId;
  String? achievements;
  AchievementType? achievementType;
  String? achievementDesc;
  String? attachmentUrl;
  int? isResourceLibrary;
  int? resourceLibraryId;
  String? cloudinaryId;
  String? cloudinaryUrl;
  String? cloudinarySecureUrl;
  int? createdBy;
  int? adminUserId;
  DateTime? lastModified;
  String? position;
  dynamic resourceType;
  int? teamId;
  String? resourceVideoLink;
  String? cloudinaryAudioSecureUrl;
  String? feedback;
  String? achived;
  dynamic submitStatus;
  String? newCreatedOn;

  factory CareerAchievement.fromJson(Map<String, dynamic> json) =>
      CareerAchievement(
        id: json["id"],
        careerId: json["career_id"],
        achievements: json["achievements"],
        achievementType: achievementTypeValues.map[json["achievement_type"]],
        achievementDesc: json["achievement_desc"],
        attachmentUrl: json["attachment_url"],
        isResourceLibrary: json["is_resource_library"],
        resourceLibraryId: json["resource_library_id"],
        cloudinaryId: json["cloudinaryId"],
        cloudinaryUrl:
            json["cloudinaryUrl"] == null ? null : json["cloudinaryUrl"],
        cloudinarySecureUrl: json["cloudinarySecureUrl"],
        createdBy: json["created_by"],
        adminUserId: json["admin_user_id"],
        lastModified: DateTime.parse(json["last_modified"]),
        position: json["position"],
        resourceType: json["resource_type"],
        teamId: json["team_id"],
        resourceVideoLink: json["resource_video_link"] == null
            ? null
            : json["resource_video_link"],
        cloudinaryAudioSecureUrl: json["cloudinaryAudioSecureUrl"] == null
            ? null
            : json["cloudinaryAudioSecureUrl"],
        feedback: json["feedback"] == null ? null : json["feedback"],
        achived: json["achived"],
        submitStatus: json["submit_status"],
        newCreatedOn:
            json["new_created_on"] == null ? null : json["new_created_on"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "career_id": careerId,
        "achievements": achievements,
        "achievement_type": achievementTypeValues.reverse[achievementType],
        "achievement_desc": achievementDesc,
        "attachment_url": attachmentUrl,
        "is_resource_library": isResourceLibrary,
        "resource_library_id": resourceLibraryId,
        "cloudinaryId": cloudinaryId,
        "cloudinaryUrl": cloudinaryUrl == null ? null : cloudinaryUrl,
        "cloudinarySecureUrl": cloudinarySecureUrl,
        "created_by": createdBy,
        "admin_user_id": adminUserId,
        "last_modified": lastModified!.toIso8601String(),
        "position": position,
        "resource_type": resourceType,
        "team_id": teamId,
        "resource_video_link":
            resourceVideoLink == null ? null : resourceVideoLink,
        "cloudinaryAudioSecureUrl":
            cloudinaryAudioSecureUrl == null ? null : cloudinaryAudioSecureUrl,
        "feedback": feedback == null ? null : feedback,
        "achived": achived,
        "submit_status": submitStatus,
        "new_created_on": newCreatedOn == null ? null : newCreatedOn,
      };
}

enum AchievementType { NEW, RESOURCE_LIBRARY }

final achievementTypeValues = EnumValues({
  "new": AchievementType.NEW,
  "resourceLibrary": AchievementType.RESOURCE_LIBRARY
});

class CareerPath {
  CareerPath({
    this.id,
    this.careerPath,
    this.completed,
    this.teamId,
  });

  int? id;
  String? careerPath;
  dynamic completed;
  dynamic teamId;

  factory CareerPath.fromJson(Map<String, dynamic> json) => CareerPath(
        id: json["id"],
        careerPath: json["career_path"],
        completed: json["completed"],
        teamId: json["team_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "career_path": careerPath,
        "completed": completed,
        "team_id": teamId,
      };
}

class CountArray {
  CountArray({
    this.currentCount,
    this.submitCount,
    this.completeCount,
  });

  int? currentCount;
  int? submitCount;
  int? completeCount;

  factory CountArray.fromJson(Map<String, dynamic> json) => CountArray(
        currentCount: json["currentCount"],
        submitCount: json["submitCount"],
        completeCount: json["completeCount"],
      );

  Map<String, dynamic> toJson() => {
        "currentCount": currentCount,
        "submitCount": submitCount,
        "completeCount": completeCount,
      };
}

class Mycount {
  Mycount({
    this.initial,
    this.save,
    this.submit,
    this.completed,
  });

  int? initial;
  int? save;
  int? submit;
  int? completed;

  factory Mycount.fromJson(Map<String, dynamic> json) => Mycount(
        initial: json["initial"],
        save: json["save"],
        submit: json["submit"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "initial": initial,
        "save": save,
        "submit": submit,
        "completed": completed,
      };
}

class Question {
  Question({
    this.queId,
    this.question,
    this.ansId,
    this.answer,
  });

  int? queId;
  String? question;
  int? ansId;
  String? answer;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        queId: json["que_id"],
        question: json["question"],
        ansId: json["ans_id"] == null ? null : json["ans_id"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "que_id": queId,
        "question": question,
        "ans_id": ansId == null ? null : ansId,
        "answer": answer,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
