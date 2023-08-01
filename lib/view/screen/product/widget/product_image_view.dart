import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/response/detailsProduct_model.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/product_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../provider/wishlist_provider.dart';
import '../../../../util/app_constants.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/responsive.dart';
import '../product_image_screen.dart';
import 'favourite_button.dart';

class ProductImageView extends StatelessWidget {
  final DetailsProductModel detailsProduct;
  ProductImageView({required this.detailsProduct});
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ProductImageScreen(
                    imageList: detailsProduct.fetchedPhotoData ?? [],
                    title: Provider.of<LocalizationProvider>(context).locale!.languageCode == "en"
                        ? detailsProduct.product!.titleEn!
                        : detailsProduct.product!.title!
                )));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              boxShadow: [BoxShadow(
                  color: Colors.grey[
                    Provider.of<ThemeProvider>(context).darkTheme
                        ? 700 : 300]!, spreadRadius: 1, blurRadius: 5)],
              gradient: Provider.of<ThemeProvider>(context).darkTheme
                  ? null
                  : LinearGradient(
                colors: [ColorResources.WHITE, ColorResources.IMAGE_BG],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.width - 120,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: detailsProduct.fetchedPhotoData!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
                      child: FadeInImage.assetNetwork(
                        placeholder: Images.placeholder,
                        height: width(context),
                        width: width(context),
                        image: '${AppConstants.BASE_URL_IMAGE}'
                            '${detailsProduct.fetchedPhotoData![index]}',
                        imageErrorBuilder: (c, o, s) => Image.asset(
                          Images.placeholder,
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    Provider.of<ProductProvider>(context,
                        listen: false).setImageSliderSelectedIndex(index);
                  },
                ),
              ),

              Positioned(
                left: 0, right: 0, bottom: 0,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _indicators(context),
                  ),
                ),
              ),

              // Favourite Button
              Positioned(
                bottom: 20,
                right: 20,
                child: FavouriteButton(
                  backgroundColor: ColorResources.getImageBg(context),
                  favColor: ColorResources.getPrimary(context),
                  isSelected: Provider.of<WishProvider>(context,
                      listen: false).isWish,
                  productId: detailsProduct.product!.id,
                ),
              ),
            ]),
          ),
        ),

        // Image List
        Container(
          height: 60,
          margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          alignment: Alignment.center,
          child: ListView.builder(
            itemCount: detailsProduct.fetchedPhotoData!.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _controller.animateToPage(index, duration: Duration(microseconds: 300), curve: Curves.easeInOut);
                },
                child: Container(
                  width: 60,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).highlightColor,
                    border: Provider.of<ProductProvider>(context
                    ).imageSliderIndex == index
                        ? Border.all(color: ColorResources.getPrimary(context), width: 2) : null,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder,
                      image: '${AppConstants.BASE_URL_IMAGE}'
                          '${detailsProduct.fetchedPhotoData![index]}',
                      imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _indicators(BuildContext context) {
    List<Widget> indicators = [];
    for (int index = 0; index < detailsProduct.fetchedPhotoData!.length; index++) {
      indicators.add(TabPageSelectorIndicator(
        backgroundColor: index == Provider.of<ProductProvider>(context
        ).imageSliderIndex
            ? Theme.of(context).primaryColor
            : ColorResources.WHITE,
        borderColor: ColorResources.WHITE,
        size: 10,
      ));
    }
    return indicators;
  }
}