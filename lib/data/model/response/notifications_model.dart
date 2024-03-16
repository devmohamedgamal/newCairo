class NotificationModel {
  List<Notif>? notifications;
  NotificationModel({this.notifications});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notifications:
            List<Notif>.from(json["allnot"].map((x) => Notif.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "allnot": List<dynamic>.from(notifications!.map((x) => x.toJson())),
      };
}

class Notif {
  String? notId;
  String? title;
  dynamic massage;
  String? userId;
  DateTime? createdAt;
  String? status;

  Notif({
    this.notId,
    this.title,
    this.massage,
    this.userId,
    this.createdAt,
    this.status,
  });

  factory Notif.fromJson(Map<String, dynamic> json) => Notif(
        notId: json["not_id"],
        title: json["title"],
        massage: json["massage"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "not_id": notId,
        "title": title,
        "massage": massage,
        "user_id": userId,
        "created_at": createdAt!.toIso8601String(),
        "status": status,
      };
}
