import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/auth_provider.dart';
import 'package:lemirageelevators/provider/product_provider.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import '../../../data/model/body/review_body.dart';
import '../../../localization/language_constrants.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../baseWidget/button/custom_button.dart';
import '../../baseWidget/textfield/custom_textfield.dart';

class ReviewBottomSheet extends StatefulWidget {
  final String productID;
  final Function() callback;

  ReviewBottomSheet({required this.productID, required this.callback});

  @override
  _ReviewBottomSheetState createState() => _ReviewBottomSheetState();
}
class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.cancel, color: ColorResources.getRed(context)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Text(getTranslated('review_your_experience', context)!,
                style: cairoRegular),
            Divider(height: 5),
            Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Row(children: [
                Expanded(
                    child: Text(getTranslated('your_rating', context)!,
                        style: cairoBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL))),
                Container(
                  height: 30,
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorResources.getLowGreen(context),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Icon(
                          Icons.star,
                          size: 20,
                          color: Provider.of<ProductProvider>(context).rating! <
                                  (index + 1)
                              ? Theme.of(context).highlightColor
                              : ColorResources.getYellow(context),
                        ),
                        onTap: () =>
                            Provider.of<ProductProvider>(context, listen: false)
                                .setRating(index + 1),
                      );
                    },
                  ),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: CustomTextField(
                maxLine: 4,
                hintText: getTranslated('write_your_experience_here', context),
                controller: _controller,
                textInputAction: TextInputAction.done,
                fillColor: ColorResources.getLowGreen(context),
              ),
            ),
            Provider.of<ProductProvider>(context).errorText != null
                ? Text(Provider.of<ProductProvider>(context).errorText!,
                    style: cairoRegular.copyWith(color: ColorResources.RED))
                : SizedBox.shrink(),

            Builder(
              builder: (context) => !Provider.of<ProductProvider>(context).isLoading
                  ? Padding(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                      child: CustomButton(
                        buttonText: getTranslated('submit', context)!,
                        onTap: () async {
                          if (Provider.of<ProductProvider>(context,
                              listen: false).rating == 0) {
                            Provider.of<ProductProvider>(context, listen: false)
                                .setErrorText(getTranslated("add_rating", context)!);
                          } else if (_controller.text.isEmpty) {
                            Provider.of<ProductProvider>(context, listen: false)
                                .setErrorText(getTranslated("Write_something", context)!);
                          } else {
                            Provider.of<ProductProvider>(context, listen: false)
                                .setErrorText('');
                            ReviewBody reviewBody = ReviewBody(
                              clientId: Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .user!
                                  .userId,
                              productId: widget.productID,
                              rate: Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .rating
                                  .toString(),
                              message: _controller.text.isEmpty
                                  ? ''
                                  : _controller.text,
                            );

                            await Provider.of<ProductProvider>(context,
                                    listen: false)
                                .submitReview(reviewBody, _route);
                          }
                        },
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor))),
            ),
          ]),
    );
  }

  _route(bool isSuccess, String message) {
    if (isSuccess) {
      Navigator.pop(context);
      widget.callback();
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      _controller.clear();
    } else {
      Provider.of<ProductProvider>(context, listen: false)
          .setErrorText(message);
    }
  }
}

class MyPainter extends CustomPainter {
  Color lineColor = Colors.transparent;
  Color? completeColor;
  double? width;

  MyPainter({this.completeColor, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = new Paint()
      ..color = completeColor!
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width!;

    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    var percent = (size.width * 0.001) / 2;
    double arcAngle = 2 * pi * percent;

    for (var i = 0; i < 8; i++) {
      var init = (-pi / 2) * (i / 2);
      canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), init,
          arcAngle, false, complete);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
