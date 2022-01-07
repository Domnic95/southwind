// To parse this JSON data, do
//
//     final timerCard = timerCardFromJson(jsonString);

import 'dart:convert';

TimerCard timerCardFromJson(String str) => TimerCard.fromJson(json.decode(str));

String timerCardToJson(TimerCard data) => json.encode(data.toJson());

class TimerCard {
  TimerCard({
    this.id,
    this.profileId,
    this.timeIn,
    this.timeOut,
    this.latIn,
    this.latOut,
    this.longIn,
    this.longOut,
    this.totHours,
    this.createdAt,
    this.clientId,
    this.notificationSent,
    this.inOut,
    this.cronInsert,
    this.gpsIn,
    this.gpsOut,
    this.kiosk,
  });

  int? id;
  int? profileId;
  DateTime? timeIn;
  dynamic? timeOut; // 
  String? latIn;
  dynamic latOut;
  String? longIn;
  dynamic? longOut;
  dynamic? totHours;
  DateTime? createdAt;
  int? clientId;
  int? notificationSent;
  int? inOut;
  int? cronInsert;
  int? gpsIn;
  dynamic gpsOut;
  int? kiosk;

  factory TimerCard.fromJson(Map<String, dynamic> json) => TimerCard(
        id: json["id"],
        profileId: json["profile_id"],
        timeIn: DateTime.parse(json["time_in"]),
        timeOut: json["time_out"],
        latIn: json["lat_in"],
        latOut: json["lat_out"],
        longIn: json["long_in"],
        longOut: json["long_out"],
        totHours: json["tot_hours"],
        createdAt: DateTime.parse(json["created_at"]),
        clientId: json["client_id"],
        notificationSent: json["notification_sent"],
        inOut: json["in_out"],
        cronInsert: json["cron_insert"],
        gpsIn: json["gps_in"],
        gpsOut: json["gps_out"],
        kiosk: json["kiosk"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profile_id": profileId,
        "time_in": timeIn!.toIso8601String(),
        "time_out": timeOut,
        "lat_in": latIn,
        "lat_out": latOut,
        "long_in": longIn,
        "long_out": longOut,
        "tot_hours": totHours,
        "created_at": createdAt!.toIso8601String(),
        "client_id": clientId,
        "notification_sent": notificationSent,
        "in_out": inOut,
        "cron_insert": cronInsert,
        "gps_in": gpsIn,
        "gps_out": gpsOut,
        "kiosk": kiosk,
      };
}
