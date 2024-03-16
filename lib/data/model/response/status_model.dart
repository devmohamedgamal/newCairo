class StatusModel {
  StatusModel({
    this.status,
    this.massage,
    this.refId,
    this.url,
  });

  bool? status;
  String? massage;
  String? refId;
  String? url;

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        status: json["status"],
        massage: json["massage"],
        refId: json["ref_id"] ?? null,
        url: json["url"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "massage": massage,
        "ref_id": refId ?? null,
        "url": url ?? null,
      };
}
