import 'package:dio/dio.dart';
import '../../util/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

class GalleryRepo {
  final DioClient dioClient;
  GalleryRepo({required this.dioClient});

  Future<ApiResponse> getVideosList() async {
    try {
      final response = await dioClient.get(AppConstants.VIDEO_URL);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getAlbumsList() async {
    try {
      final response = await dioClient.get(AppConstants.ALL_ALBUMS_URL);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getDetailsAlbum(String albumId) async {
    try {
      final response = await dioClient.get(AppConstants.ALBUM_URL + albumId);
      return ApiResponse.withSuccess(response);
    } on DioError catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}