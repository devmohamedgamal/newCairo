class AlbumsModel {
  AlbumsModel({
    this.album,
    this.photos,
  });

  Album? album;
  List<Photos>? photos;

  factory AlbumsModel.fromJson(Map<String, dynamic> json) => AlbumsModel(
    album: Album.fromJson(json["album"]),
    photos: List<Photos>.from(json["fetched_photo_data"].map((x) => Photos.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "album": album!.toJson(),
    "fetched_photo_data": List<dynamic>.from(photos!.map((x) => x.toJson())),
  };
}

class Album {
  Album({
    this.albumId,
    this.title,
    this.avatar,
    this.description,
    this.titleEn,
    this.updatedAt,
    this.descriptionEn,
    this.detailsEn,
    this.status,
  });

  String? albumId;
  String? title;
  String? avatar;
  String? description;
  String? titleEn;
  DateTime? updatedAt;
  String? descriptionEn;
  String? detailsEn;
  String? status;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    albumId: json["album_id"],
    title: json["title"],
    avatar: json["avatar"],
    description: json["description"],
    titleEn: json["titleEN"],
    updatedAt: DateTime.parse(json["updated_at"]),
    descriptionEn: json["descriptionEN"],
    detailsEn: json["detailsEN"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "album_id": albumId,
    "title": title,
    "avatar": avatar,
    "description": description,
    "titleEN": titleEn,
    "updated_at": updatedAt!.toIso8601String(),
    "descriptionEN": descriptionEn,
    "detailsEN": detailsEn,
    "status": status,
  };
}

class Photos {
  Photos({
    this.id,
    this.title,
    this.albumId,
    this.avatar,
  });

  String? id;
  dynamic title;
  String? albumId;
  String? avatar;

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
    id: json["id"],
    title: json["title"],
    albumId: json["album_id"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "album_id": albumId,
    "avatar": avatar,
  };
}