import 'package:flutter/material.dart';
import 'package:lemirageelevators/provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../util/images.dart';
import '../category/widgets/view_category_product.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        .getAllProductList(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ViewCategoryProduct()));
                  },
                ),
                const CustomCategoryItem(
                  imageUrl: Images.shipingIcon,
                  name: 'بيع و أشتري',
                ),
                const CustomCategoryItem(
                  imageUrl: Images.specialOfferIcon,
                  name: 'عروض',
                ),
                const CustomCategoryItem(
                  imageUrl: Images.jopsIcon,
                  name: 'وظائف',
                ),
                const CustomCategoryItem(
                  imageUrl: Images.carServicesIcon,
                  name: 'توصيلة',
                ),
                const CustomCategoryItem(
                  imageUrl: Images.otlopIcon,
                  name: 'أطلب',
                ),
                const CustomCategoryItem(
                  imageUrl: Images.eventIcon,
                  name: 'ايفنتات',
                ),
                const CustomCategoryItem(
                  imageUrl: Images.newsIcon,
                  name: 'أخبار',
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
