class AlbumsModel {
  AlbumsModel({
    this.albums,
  });

  Albums? albums;

  factory AlbumsModel.fromJson(Map<String, dynamic> json) => AlbumsModel(
    albums: Albums.fromJson(json["albums"]),
  );

  Map<String, dynamic> toJson() => {
    "albums": albums!.toJson(),
  };
}

class Albums {
  Albums({
    this.information,
    this.photo,
  });

  List<Information>? information;
  List<List<Photo>>? photo;

  factory Albums.fromJson(Map<String, dynamic> json) => Albums(
    information: List<Information>.from(json["information"].map((x) => Information.fromJson(x))),
    photo: List<List<Photo>>.from(json["photo"].map((x) => List<Photo>.from(x.map((x) => Photo.fromJson(x))))),
  );

  Map<String, dynamic> toJson() => {
    "information": List<dynamic>.from(information!.map((x) => x.toJson())),
    "photo": List<dynamic>.from(photo!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
  };
}

class Information {
  String? albumId;
  String? title;
  String? avatar;
  String? description;
  String? titleEn;
  DateTime? updatedAt;
  String? descriptionEN;
  String? detailsEn;
  String? status;

  Information({
    this.albumId,
    this.title,
    this.avatar,
    this.description,
    this.titleEn,
    this.updatedAt,
    this.descriptionEN,
    this.detailsEn,
    this.status,
  });

  factory Information.fromJson(Map<String, dynamic> json) => Information(
    albumId: json["album_id"],
    title: json["title"],
    avatar: json["avatar"],
    description: json["description"],
    titleEn: json["titleEN"],
    updatedAt: DateTime.parse(json["updated_at"]),
    descriptionEN: json["descriptionEN"],
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
    "descriptionEN": descriptionEN,
    "detailsEN": detailsEn,
    "status": status,
  };
}

class Photo {
  Photo({
    this.id,
    this.title,
    this.albumId,
    this.avatar,
  });

  String? id;
  dynamic title;
  String? albumId;
  String? avatar;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
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