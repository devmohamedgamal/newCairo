import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/theme_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/textStyle.dart';
import '../home/home_screen.dart';

class AllProductScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  AllProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
            ? Colors.black
            : Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              size: 20, color: ColorResources.WHITE),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(getTranslated('featured_products', context),
            style: cairoRegular.copyWith(
                fontSize: 18, color: ColorResources.WHITE)),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {},
          child: CustomScrollView(
            controller: _scrollController,
            slivers: const [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: HomeView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
