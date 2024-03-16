class VideosModel {
  VideosModel({
    this.videos,
  });

  List<Video>? videos;

  factory VideosModel.fromJson(Map<String, dynamic> json) => VideosModel(
        videos: List<Video>.from(
            json["fetched_video_data"].map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fetched_video_data":
            List<dynamic>.from(videos!.map((x) => x.toJson())),
      };
}

class Video {
  Video({
    this.id,
    this.title,
    this.description,
    this.youtube,
    this.titleEn,
    this.updatedAt,
    this.descriptionEn,
    this.status,
  });

  String? id;
  String? title;
  String? description;
  String? youtube;
  String? titleEn;
  DateTime? updatedAt;
  String? descriptionEn;
  String? status;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        youtube: json["youtube"],
        titleEn: json["titleEN"],
        updatedAt: DateTime.parse(json["updated_at"]),
        descriptionEn: json["descriptionEN"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "youtube": youtube,
        "titleEN": titleEn,
        "updated_at": updatedAt!.toIso8601String(),
        "descriptionEN": descriptionEn,
        "status": status,
      };
}
