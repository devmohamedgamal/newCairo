import 'package:flutter/material.dart';
import 'package:newcairo/provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../util/images.dart';
import '../../setting/settings_screen.dart';
import '../category/widgets/view_category_product.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SettingsScreen(),
            ),
          );
        },
        child: Icon(Icons.settings),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.backgeoundHome),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
              childAspectRatio: 0.9,
              children: [
                CustomCategoryItem(
                  imageUrl: Images.ServicesIcon,
                  name: 'دليل الخدمات',
                  onTap: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .getFilterProductList(context, category: 'service');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ViewCategoryProduct(
                          category: 'دليل الخدمات',
                        ),
                      ),
                    );
                  },
                ),
                CustomCategoryItem(
                  imageUrl: Images.shipingIcon,
                  name: 'بيع و أشتري',
                  onTap: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .getFilterProductList(context, category: 'product');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ViewCategoryProduct(
                          category: 'بيع و أشتري',
                        ),
                      ),
                    );
                  },
                ),
                CustomCategoryItem(
                  imageUrl: Images.specialOfferIcon,
                  name: 'عروض',
                  onTap: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .getFilterProductList(context, category: 'offer');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ViewCategoryProduct(
                          category: 'عروض',
                        ),
                      ),
                    );
                  },
                ),
                CustomCategoryItem(
                  imageUrl: Images.jopsIcon,
                  name: 'وظائف',
                  onTap: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .getFilterProductList(context, category: 'jop');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ViewCategoryProduct(
                          category: 'وظائف',
                        ),
                      ),
                    );
                  },
                ),
                CustomCategoryItem(
                  imageUrl: Images.carServicesIcon,
                  name: 'توصيلة',
                  onTap: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .getFilterProductList(context, category: 'carpool');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ViewCategoryProduct(
                          category: 'توصيلة',
                        ),
                      ),
                    );
                  },
                ),
                CustomCategoryItem(
                  imageUrl: Images.otlopIcon,
                  name: 'أطلب',
                  onTap: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .getFilterProductList(context, category: 'Otlop');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ViewCategoryProduct(
                          category: 'أطلب',
                        ),
                      ),
                    );
                  },
                ),
                CustomCategoryItem(
                  imageUrl: Images.eventIcon,
                  name: 'ايفنتات',
                  onTap: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .getFilterProductList(context, category: 'event');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ViewCategoryProduct(
                          category: 'ايفنتات',
                        ),
                      ),
                    );
                  },
                ),
                CustomCategoryItem(
                  imageUrl: Images.newsIcon,
                  name: 'أخبار',
                  onTap: () async {
                    await Provider.of<ProductProvider>(context, listen: false)
                        .getFilterProductList(context, category: 'news');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ViewCategoryProduct(
                          category: 'أخبار',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCategoryItem extends StatelessWidget {
  const CustomCategoryItem(
      {Key? key, required this.name, required this.imageUrl, this.onTap})
      : super(key: key);
  final String name, imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        width: 150,
        decoration: const BoxDecoration(
          color: Color(0xff8FC3FD),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(1),
            topRight: Radius.circular(100),
            bottomLeft: Radius.circular(100),
            bottomRight: Radius.circular(100),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageUrl,
              height: 100,
            ),
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'Cairo',
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
