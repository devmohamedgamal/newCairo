import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import '../../../../data/model/response/notifications_model.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/responsive.dart';

class NotificationDialog extends StatelessWidget {
  final Notif notification;
  NotificationDialog({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.width-130, width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_LARGE),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor.withOpacity(0.20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                image: '${AppConstants.BASE_URL_IMAGE}wef.png',
                height: height(context)-130,
                width: width(context),
                fit: BoxFit.cover,
                imageErrorBuilder: (c, o, s) => Image.asset(
                  Images.placeholder, height: MediaQuery.of(context).size.width-130,
                  width: MediaQuery.of(context).size.width, fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_LARGE),
            child: Text(
              notification.title!,
              textAlign: TextAlign.center,
              style: cairoSemiBold.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Text(
              notification.massage ?? "",
              textAlign: TextAlign.center,
              style: cairoRegular,
            ),
          ),
        ],
      ),
    );
  }
}