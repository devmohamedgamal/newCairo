import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/home_provider.dart';
import 'package:lemirageelevators/util/app_constants.dart';
import 'package:lemirageelevators/view/screen/category/widgets/view_category_product.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/home_model.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/product_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/textStyle.dart';
import '../../baseWidget/custom_app_bar.dart';

class AllCategoryScreen extends StatefulWidget {
  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  @override
  void initState() {
    super.initState();
    if (Provider.of<HomeProvider>(context, listen: false).categories.length >
            0 &&
        Provider.of<ProductProvider>(context, listen: false)
                .categoryProductList
                .length ==
            0) {
      Provider.of<ProductProvider>(context, listen: false)
          .initCategoryProductList(
              Provider.of<HomeProvider>(context, listen: false)
                  .categories[Provider.of<HomeProvider>(context, listen: false)
                      .categorySelectedIndex!]
                  .categoryId!,
              context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('CATEGORY', context)!),
          Expanded(
            child: Consumer<HomeProvider>(
              builder: (context, categoryProvider, child) {
                return categoryProvider.categories.length != 0
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(top: 3),
                          height: double.infinity,
                          decoration: BoxDecoration(
                              color: Theme.of(context).highlightColor,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[
                                        Provider.of<ThemeProvider>(context)
                                                .darkTheme
                                            ? 700
                                            : 200]!,
                                    spreadRadius: 1,
                                    blurRadius: 1)
                              ],
                              border: Border(
                                  left: BorderSide(
                                      color: ColorResources.getRed(context)))),
                          child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: categoryProvider.categories.length,
                            padding: EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              Category _category =
                                  categoryProvider.categories[index];
                              return InkWell(
                                onTap: () {
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .changeSelectedIndex(index);
                                  Provider.of<ProductProvider>(context,
                                          listen: false)
                                      .initCategoryProductList(
                                          categoryProvider
                                              .categories[index].categoryId!,
                                          context);
                                },
                                child: CategoryItem(
                                  title: _category.catTitle!,
                                  icon: _category.avatar!,
                                  isSelected:
                                      categoryProvider.categorySelectedIndex ==
                                          index,
                                ),
                              );
                            },
                          ),
                        ),
                        ViewCategoryProduct(),
                      ])
                    : Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor)));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;

  CategoryItem(
      {required this.title, required this.icon, required this.isSelected});

  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? ColorResources.getPrimary(context) : null,
      ),
      child: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color: isSelected
                      ? Theme.of(context).highlightColor
                      : Theme.of(context).hintColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                fit: BoxFit.cover,
                image: '${AppConstants.BASE_URL_IMAGE}$icon',
                imageErrorBuilder: (c, o, s) =>
                    Image.asset(Images.placeholder, fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: cairoSemiBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                  color: isSelected
                      ? Theme.of(context).highlightColor
                      : Theme.of(context).hintColor,
                )),
          ),
        ]),
      ),
    );
  }
}
