// To parse this JSON data, do
//
//     final individualSurvey = individualSurveyFromJson(jsonString);

import 'dart:convert';


class IndividualSurvey {
  IndividualSurvey({
    this.id,
    this.title,
    this.notificationText,
    this.sendTo,
    this.teamId,
    this.individualId,
    this.notifyOn,
    this.createdBy,
    this.creatorGuard,
    this.notifyStatus,
    this.createdAt,
    this.updatedAt,
    this.commentCount,
    this.unseenCount,
    this.likesCount,
    this.firstName,
    this.lastName,
    this.userImage,
    this.liked,
    this.surveyNotificationQuestion,
    this.surveyNotificationProfiles,
    // this.user,
  });

  int? id;
  String? title;
  String? notificationText;
  String? sendTo;
  dynamic teamId;
  int? individualId;
  DateTime? notifyOn;
  int? createdBy;
  String? creatorGuard;
  String? notifyStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? commentCount;
  int? unseenCount;
  int? likesCount;
  String? firstName;
  String? lastName;
  String? userImage;
  bool? liked;
  List<SurveyNotificationQuestion>? surveyNotificationQuestion;
  List<SurveyNotificationProfile>? surveyNotificationProfiles;
  // User user;

  factory IndividualSurvey.fromJson(Map<String, dynamic> json) =>
      IndividualSurvey(
        id: json["id"],
        title: json["title"],
        notificationText: json["notification_text"],
        sendTo: json["send_to"],
        teamId: json["team_id"],
        individualId: json["individual_id"],
        notifyOn: DateTime.parse(json["notify_on"]),
        createdBy: json["created_by"],
        creatorGuard: json["creator_guard"],
        notifyStatus: json["notify_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        commentCount: json["comment_count"],
        unseenCount: json["unseen_count"],
        likesCount: json["likes_count"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userImage: json["user_image"],
        liked: json["liked"],
        surveyNotificationQuestion: List<SurveyNotificationQuestion>.from(
            json["survey_notification_question"]
                .map((x) => SurveyNotificationQuestion.fromJson(x))),
        surveyNotificationProfiles: List<SurveyNotificationProfile>.from(
            json["survey_notification_profiles"]
                .map((x) => SurveyNotificationProfile.fromJson(x))),
        // user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "notification_text": notificationText,
        "send_to": sendTo,
        "team_id": teamId,
        "individual_id": individualId,
        "notify_on": notifyOn!.toIso8601String(),
        "created_by": createdBy,
        "creator_guard": creatorGuard,
        "notify_status": notifyStatus,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "comment_count": commentCount,
        "unseen_count": unseenCount,
        "likes_count": likesCount,
        "first_name": firstName,
        "last_name": lastName,
        "user_image": userImage,
        "liked": liked,
        "survey_notification_question": List<dynamic>.from(
            surveyNotificationQuestion!.map((x) => x.toJson())),
        "survey_notification_profiles": List<dynamic>.from(
            surveyNotificationProfiles!.map((x) => x.toJson())),
        // "user": user.toJson(),
      };
}

class SurveyNotificationProfile {
  SurveyNotificationProfile({
    this.id,
    this.surveyNotificationId,
    this.profileId,
    this.isViewed,
    this.isLiked,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? surveyNotificationId;
  int? profileId;
  int? isViewed;
  int? isLiked;
  dynamic createdAt;
  DateTime? updatedAt;

  factory SurveyNotificationProfile.fromJson(Map<String, dynamic> json) =>
      SurveyNotificationProfile(
        id: json["id"],
        surveyNotificationId: json["survey_notification_id"],
        profileId: json["profile_id"],
        isViewed: json["is_viewed"],
        isLiked: json["is_liked"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "survey_notification_id": surveyNotificationId,
        "profile_id": profileId,
        "is_viewed": isViewed,
        "is_liked": isLiked,
        "created_at": createdAt,
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class SurveyNotificationQuestion {
  SurveyNotificationQuestion({
    this.id,
    this.surveyNotificationId,
    this.question,
    this.other,
    this.surveyNotificationOption,
    this.surveyNotificationAnswer,
  });

  int? id;
  int? surveyNotificationId;
  String? question;
  int? other;
  List<SurveyNotificationOption>? surveyNotificationOption;
  List<dynamic>? surveyNotificationAnswer;

  factory SurveyNotificationQuestion.fromJson(Map<String, dynamic> json) =>
      SurveyNotificationQuestion(
        id: json["id"],
        surveyNotificationId: json["survey_notification_id"],
        question: json["question"],
        other: json["other"],
        surveyNotificationOption: List<SurveyNotificationOption>.from(
            json["survey_notification_option"]
                .map((x) => SurveyNotificationOption.fromJson(x))),
        surveyNotificationAnswer: List<dynamic>.from(
            json["survey_notification_answer"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "survey_notification_id": surveyNotificationId,
        "question": question,
        "other": other,
        "survey_notification_option": List<dynamic>.from(
            surveyNotificationOption!.map((x) => x.toJson())),
        "survey_notification_answer":
            List<dynamic>.from(surveyNotificationAnswer!.map((x) => x)),
      };
}

class SurveyNotificationOption {
  SurveyNotificationOption({
    this.id,
    this.surveyNotificationId,
    this.surveyNotificationQuestionId,
    this.optionName,
  });

  int? id;
  int? surveyNotificationId;
  int? surveyNotificationQuestionId;
  String? optionName;

  factory SurveyNotificationOption.fromJson(Map<String, dynamic> json) =>
      SurveyNotificationOption(
        id: json["id"],
        surveyNotificationId: json["survey_notification_id"],
        surveyNotificationQuestionId: json["survey_notification_question_id"],
        optionName: json["option_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "survey_notification_id": surveyNotificationId,
        "survey_notification_question_id": surveyNotificationQuestionId,
        "option_name": optionName,
      };
}

// class User {
//     User({
//         this.id,
//         this.userEmail,
//         this.firstName,
//         this.lastName,
//         this.organisationName,
//         this.franchiseId,
//         this.bannerId,
//         this.role,
//         this.status,
//         this.logoImage,
//         this.box1Title,
//         this.box1Value,
//         this.box1Change,
//         this.box2Title,
//         this.box2Value,
//         this.box2Change,
//         this.box3Title,
//         this.box3Value,
//         this.box3Change,
//         this.box4Title,
//         this.box4Value,
//         this.box4Change,
//         this.ajs,
//         this.ajsYesterday,
//         this.jobs,
//         this.jobsYesterday,
//         this.revenue,
//         this.revenueYesterday,
//         this.trend,
//         this.trendYesterday,
//         this.timezoneId,
//         this.latitude,
//         this.longitude,
//         this.kiosk,
//     });

//     int id;
//     String userEmail;
//     String firstName;
//     String lastName;
//     String organisationName;
//     int franchiseId;
//     int bannerId;
//     int role;
//     int status;
//     dynamic logoImage;
//     String box1Title;
//     String box1Value;
//     String box1Change;
//     String box2Title;
//     String box2Value;
//     String box2Change;
//     String box3Title;
//     String box3Value;
//     String box3Change;
//     String box4Title;
//     String box4Value;
//     String box4Change;
//     String ajs;
//     String ajsYesterday;
//     String jobs;
//     String jobsYesterday;
//     String revenue;
//     String revenueYesterday;
//     String trend;
//     String trendYesterday;
//     int timezoneId;
//     String latitude;
//     String longitude;
//     int kiosk;

//     factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         userEmail: json["user_email"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         organisationName: json["organisation_name"],
//         franchiseId: json["franchise_id"],
//         bannerId: json["banner_id"],
//         role: json["role"],
//         status: json["status"],
//         logoImage: json["logo_image"],
//         box1Title: json["box1_title"],
//         box1Value: json["box1_value"],
//         box1Change: json["box1_change"],
//         box2Title: json["box2_title"],
//         box2Value: json["box2_value"],
//         box2Change: json["box2_change"],
//         box3Title: json["box3_title"],
//         box3Value: json["box3_value"],
//         box3Change: json["box3_change"],
//         box4Title: json["box4_title"],
//         box4Value: json["box4_value"],
//         box4Change: json["box4_change"],
//         ajs: json["ajs"],
//         ajsYesterday: json["ajs_yesterday"],
//         jobs: json["jobs"],
//         jobsYesterday: json["jobs_yesterday"],
//         revenue: json["revenue"],
//         revenueYesterday: json["revenue_yesterday"],
//         trend: json["trend"],
//         trendYesterday: json["trend_yesterday"],
//         timezoneId: json["timezone_id"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         kiosk: json["kiosk"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_email": userEmail,
//         "first_name": firstName,
//         "last_name": lastName,
//         "organisation_name": organisationName,
//         "franchise_id": franchiseId,
//         "banner_id": bannerId,
//         "role": role,
//         "status": status,
//         "logo_image": logoImage,
//         "box1_title": box1Title,
//         "box1_value": box1Value,
//         "box1_change": box1Change,
//         "box2_title": box2Title,
//         "box2_value": box2Value,
//         "box2_change": box2Change,
//         "box3_title": box3Title,
//         "box3_value": box3Value,
//         "box3_change": box3Change,
//         "box4_title": box4Title,
//         "box4_value": box4Value,
//         "box4_change": box4Change,
//         "ajs": ajs,
//         "ajs_yesterday": ajsYesterday,
//         "jobs": jobs,
//         "jobs_yesterday": jobsYesterday,
//         "revenue": revenue,
//         "revenue_yesterday": revenueYesterday,
//         "trend": trend,
//         "trend_yesterday": trendYesterday,
//         "timezone_id": timezoneId,
//         "latitude": latitude,
//         "longitude": longitude,
//         "kiosk": kiosk,
//     };
// }
