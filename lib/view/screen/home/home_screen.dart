import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/cart_provider.dart';
import 'package:lemirageelevators/provider/home_provider.dart';
import 'package:lemirageelevators/view/screen/home/widget/banners_view.dart';
import 'package:lemirageelevators/view/screen/home/widget/category_view.dart';
import 'package:lemirageelevators/view/screen/home/widget/products_view.dart';
import 'package:lemirageelevators/view/screen/home/widget/special_offers_view.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/search_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/textStyle.dart';
import '../../baseWidget/title_row.dart';
import '../cart/cart_screen.dart';
import '../category/all_category_screen.dart';
import '../search/search_screen.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await Provider.of<HomeProvider>(context, listen: false).getHomeData(true, context);
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // App Bar
              SliverAppBar(
                floating: true,
                elevation: 0,
                centerTitle: false,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).highlightColor,
                title: Image.asset(Images.logo, height: 40),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                    },
                    icon: badge.Badge(
                      badgeContent: Text(
                          Provider.of<CartProvider>(context).cartList.length.toString(),
                        style: cairoRegular.copyWith(
                          fontSize: 10,
                          color: ColorResources.WHITE
                        )
                      ),
                      showBadge: true,
                      shape: badge.BadgeShape.circle,
                      badgeColor: Colors.red,
                      elevation: 4,
                      padding: EdgeInsets.all(4),
                      position: badge.BadgePosition.topStart(top: -9, start : -12),
                      animationType: badge.BadgeAnimationType.scale,
                      toAnimate: true,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Color(0xff666666),
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),

              // Search Button
              SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(
                      child: InkWell(
                        onTap: () {
                          Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
                          Provider.of<SearchProvider>(context, listen: false).initHistoryList();
                          Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen()));
                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: 2),
                          color: Theme.of(context).highlightColor,
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            height: 50,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: ColorResources.getGrey(context),
                              borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_SMALL),),
                            child: Row(
                                children: [
                                  Icon(
                                      Icons.search,
                                      color: ColorResources.getPrimary(context),
                                      size: Dimensions.ICON_SIZE_LARGE),
                                  SizedBox(width: 5),
                                  Text(getTranslated('SEARCH_HINT', context)!, style:
                                  cairoRegular.copyWith(color: Theme.of(context).hintColor)),
                                ]),
                          ),
                        ),
                      ),
                  ),
              ),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    /// sliders
                    Padding(
                      padding:
                          EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                      child: BannersView(),
                    ),

                    /// Category
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          Dimensions.PADDING_SIZE_SMALL,
                          Dimensions.PADDING_SIZE_DEFAULT,
                          Dimensions.PADDING_SIZE_SMALL,
                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: TitleRow(
                          title: getTranslated('CATEGORY', context)!,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => AllCategoryScreen()));
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child: CategoryView(isHomePage: true),
                    ),

                    /// Featured Deal
                    SpecialOffersView(),

                    // all product home
                    ProductView(isHomePage: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }
}