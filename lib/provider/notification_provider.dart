import 'package:flutter/material.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/notifications_model.dart';
import '../data/repository/notification_repo.dart';
import '../helper/api_checker.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepo notificationRepo;
  NotificationProvider({required this.notificationRepo});

  List<Notif>? _notificationList = [];
  List<Notif>? get notificationList => _notificationList;

  Future<void> initNotificationList(
      BuildContext context, String clientId) async {
    ApiResponse apiResponse =
        await notificationRepo.getNotificationList(clientId);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _notificationList = [];
      NotificationModel notificationModel;
      notificationModel =
          NotificationModel.fromJson(apiResponse.response!.data);
      if (notificationModel.notifications!.length != 0) {
        notificationModel.notifications!
            .forEach((notification) => _notificationList!.add(notification));
      }
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}
