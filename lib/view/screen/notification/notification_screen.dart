// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/auth_provider.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/view/baseWidget/custom_app_bar.dart';
import 'package:lemirageelevators/view/screen/notification/widget/notification_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/notification_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/responsive.dart';
import '../../../util/textStyle.dart';
import '../../baseWidget/spacer.dart';

class NotificationScreen extends StatelessWidget {
  final bool isBacButtonExist;
  NotificationScreen({this.isBacButtonExist = true});

  @override
  Widget build(BuildContext context) {
    if(Provider.of<AuthProvider>(context,
        listen: false).user != null){
    Provider.of<NotificationProvider>(context,
        listen: false).initNotificationList(context,
        Provider.of<AuthProvider>(context,listen: false).user!.userId!
        );
    }
    return Scaffold(
      body: Column(children: [
        CustomAppBar(
            title: getTranslated('notification', context)!,
            isBackButtonExist: isBacButtonExist),

        Expanded(
          child: Consumer<NotificationProvider>(
            builder: (context, notification, child) {
              return notification.notificationList != null
                  ? notification.notificationList!.length != 0
                    ? RefreshIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                  onRefresh: () async {
                    await Provider.of<NotificationProvider>(context,
                        listen: false).initNotificationList(context,
                        Provider.of<AuthProvider>(context,
                            listen: false).user!.userId!
                    );
                  },
                  child: ListView.builder(
                    itemCount: Provider.of<NotificationProvider>(context).notificationList!.length,
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_SMALL),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => showDialog(context: context,
                            builder: (context) => NotificationDialog(
                                notification: notification.notificationList![index])),
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: Dimensions.PADDING_SIZE_SMALL),
                          color: ColorResources.getGrey(context),
                          child: ListTile(
                            leading: ClipOval(
                                child: FadeInImage.assetNetwork(
                                  placeholder: Images.placeholder,
                                  height: 50, width: 50, fit: BoxFit.cover,
                                  image: '${AppConstants.BASE_URL_IMAGE}${
                                  notification.notificationList![index].title}',
                                  imageErrorBuilder: (c,o,s) =>
                                  Image.asset(Images.placeholder,
                                      height: 50, width: 50, fit: BoxFit.cover),
                            )),
                            title: Text(
                                notification.notificationList![index].title!,
                                style: cairoRegular.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL,
                            )),
                            subtitle: Text(
                              DateFormat('hh:mm  dd/MM/yyyy').format(
                                      notification.notificationList![index].createdAt!),
                              style: cairoRegular.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                  color: ColorResources.getHint(context)),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
                    : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(Images.notification_filled,
                      width: width(context)*0.5,height: height(context)*0.1),
                  HSpacer(15),
                  Text(getTranslated("no_notification", context)!,style: cairoSemiBold),
                ],
              )
                  : NotificationShimmer();
            },
          ),
        ),

      ]),
    );
  }
}

class NotificationShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
          color: ColorResources.getGrey(context),
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled: Provider.of<NotificationProvider>(context).notificationList == null,
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.notifications)),
              title: Container(height: 20, color: ColorResources.WHITE),
              subtitle: Container(height: 10, width: 50, color: ColorResources.WHITE),
            ),
          ),
        );
      },
    );
  }
}