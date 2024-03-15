import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/cart_provider.dart';
import 'package:lemirageelevators/util/color_resources.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:lemirageelevators/view/screen/cart/cart_screen.dart';
import 'package:lemirageelevators/view/screen/home/home_screen.dart';
import 'package:lemirageelevators/view/screen/order/order_screen.dart';
import 'package:provider/provider.dart';
import '../../../helper/network_info.dart';
import '../../../localization/language_constrants.dart';
import '../../../util/images.dart';
import '../../baseWidget/dialog/exit_app_dialog.dart';
import '../more/more_screen.dart';
import '../notification/notification_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DashBoardScreenState createState() => _DashBoardScreenState();
}
class _DashBoardScreenState extends State<DashBoardScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  late List<Widget> _screens ;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeView(),
      CartScreen(isBacButtonExist: false),
      OrderScreen(isBacButtonExist: false),
      NotificationScreen(isBacButtonExist: false),
      MoreScreen(),
    ];

    NetworkInfo.checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    return ExitPopUp(
      setPage: (){
        if(_pageIndex != 0) {
          _setPage(0);
        }
      },
        child: Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
            // unselectedItemColor: Theme.of(context).textTheme.bodyText1!.color,
            unselectedItemColor: ColorResources.LIGHT_SKY_BLUE,
            showUnselectedLabels: true,
            currentIndex: _pageIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              _barItem(Images.home_image, getTranslated('home', context), 0),
              _barItem(Images.cart_image, getTranslated('CART', context), 1),
              _barItem(Images.shopping_image, getTranslated('orders', context), 2),
              _barItem(Images.notification, getTranslated('notification', context), 3),
              _barItem(Images.more_image, getTranslated('more', context), 4),
            ],
            onTap: (int index) {
              _setPage(index);
            },
          ),
          body: PageView.builder(
            controller: _pageController,
            itemCount: _screens.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return _screens[index];
            },
          ),
        ),
    );
  }

  BottomNavigationBarItem _barItem(String icon,String label,int index) {
    if(index == 1){
      return BottomNavigationBarItem(
        icon: badge.Badge(
          badgeContent: Text(
              Provider.of<CartProvider>(context).cartList.length.toString(),
              style: cairoRegular.copyWith(
                  fontSize: 10,
                  color: ColorResources.WHITE
              )
          ),
          showBadge: Provider.of<CartProvider>(context).cartList.length > 0,
          shape: badge.BadgeShape.circle,
          badgeColor: Colors.red,
          elevation: 4,
          padding: const EdgeInsets.all(4),
          position: badge.BadgePosition.topStart(top: -10),
          animationType: badge.BadgeAnimationType.scale,
          toAnimate: true,
          child: Image.asset(
            icon,
            color: index == _pageIndex
              ? Theme.of(context).primaryColor
              : ColorResources.LIGHT_SKY_BLUE,
            height: 25, width: 25,
          ),
        ),
        label: label,
      );
    }
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon, color: index == _pageIndex
          ? Theme.of(context).primaryColor
          : ColorResources.LIGHT_SKY_BLUE,
        height: 25, width: 25,
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}