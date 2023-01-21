// To parse this JSON data, do
//
//     final activity = activityFromMap(jsonString);

import 'dart:convert';

Activity? activityFromMap(String str) => Activity.fromMap(json.decode(str));

String activityToMap(Activity? data) => json.encode(data!.toMap());

class Activity {
  Activity({
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
    required this.link,
    required this.key,
    required this.accessibility,
  });

  final String? activity;
  final String? type;
  final int? participants;
  final double? price;
  final String? link;
  final String? key;
  final double? accessibility;

  factory Activity.fromMap(Map<String, dynamic> json) => Activity(
        activity: json["activity"],
        type: json["type"],
        participants: json["participants"],
        price: json["price"].toDouble(),
        link: json["link"],
        key: json["key"],
        accessibility: json["accessibility"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "activity": activity,
        "type": type,
        "participants": participants,
        "price": price,
        "link": link,
        "key": key,
        "accessibility": accessibility,
      };
}
