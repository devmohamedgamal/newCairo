import 'package:flutter/material.dart';
import 'package:lemirageelevators/util/textStyle.dart';
import 'package:provider/provider.dart';
import '../../provider/search_provider.dart';
import '../../provider/theme_provider.dart';
import '../../util/color_resources.dart';
import '../../util/dimensions.dart';
import '../../util/images.dart';

class SearchWidget extends StatelessWidget {
  final String hintText;
  final Function(String)? onTextChanged;
  final Function() onClearPressed;
  final Function(String)? onSubmit;
  SearchWidget({required this.hintText,this.onTextChanged,required this.onClearPressed,this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController(
        text: Provider.of<SearchProvider>(context).searchText);
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
        child: Image.asset(
          Images.toolbar_background,
          fit: BoxFit.fill,
          height: 58 + MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
          color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : null,
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8),
        padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        height: 50,
        alignment: Alignment.center,
        child: Row(children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(color: ColorResources.getTextBg(context), borderRadius: BorderRadius.circular(8.0)),
              child: TextFormField(
                controller: _controller,
                onFieldSubmitted: (query) {
                  onSubmit!(query);
                },
                onChanged: (query) {
                  onTextChanged!(query);
                },
                textInputAction: TextInputAction.search,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: hintText,
                  isDense: true,
                  hintStyle: cairoRegular.copyWith(color: Theme.of(context).hintColor),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: ColorResources.getColombiaBlue(context), size: Dimensions.ICON_SIZE_DEFAULT),
                  suffixIcon: Provider.of<SearchProvider>(context).searchText.isNotEmpty ? IconButton(
                    icon: Icon(Icons.clear, color: ColorResources.getChatIcon(context)),
                    onPressed: () {
                      onClearPressed();
                      _controller.clear();
                    },
                  ) : _controller.text.isNotEmpty ? IconButton(
                    icon: Icon(Icons.clear, color: ColorResources.getChatIcon(context)),
                    onPressed: () {
                      onClearPressed();
                      _controller.clear();
                    },
                  ) : null,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
        ]),
      ),
    ]);
  }
}