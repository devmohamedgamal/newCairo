import 'package:flutter/material.dart';
import '../data/model/response/albums_model.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/videos_model.dart';
import '../data/repository/gallery_repo.dart';
import '../helper/api_checker.dart';

class GalleryProvider extends ChangeNotifier {
  final GalleryRepo galleryRepo;
  GalleryProvider({required this.galleryRepo});

  List<Video> _videosList = [];
  Albums? _albums;
  bool _isLoading = false;
  bool? _hasData;

  List<Video> get videosList => _videosList;
  bool get isLoading => _isLoading;
  Albums? get albums => _albums;
  bool? get hasData => _hasData;

  Future<void> getVideosGallery(BuildContext context) async {
    ApiResponse apiResponse = await galleryRepo.getVideosList();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      VideosModel videosModel;
      videosModel = VideosModel.fromJson(apiResponse.response!.data);
      _videosList.clear();
      _videosList.addAll(videosModel.videos!);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  Future<void> getAlbumsGallery(BuildContext context) async {
    ApiResponse apiResponse = await galleryRepo.getAlbumsList();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      AlbumsModel albumsModel;
      albumsModel = AlbumsModel.fromJson(apiResponse.response!.data);
      _albums = albumsModel.albums;
    } else {
      // ignore: use_build_context_synchronously
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void getDetailsAlbums(BuildContext context, String albumId) async {
    ApiResponse apiResponse = await galleryRepo.getDetailsAlbum(albumId);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      AlbumsModel albumsModel;
      albumsModel = AlbumsModel.fromJson(apiResponse.response!.data);
      _albums = albumsModel.albums;
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}
