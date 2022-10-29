import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/category_controller.dart';
import 'package:efood_multivendor/controller/search_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/base/product_bottom_sheet.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/search/widget/filter_widget.dart';
import 'package:efood_multivendor/view/screens/search/widget/search_field.dart';
import 'package:efood_multivendor/view/screens/search/widget/search_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/route_helper.dart';
GlobalKey _orderFormKey = GlobalKey();
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoggedIn;
String searchValue = "";
  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        searchValue = _searchController.text;
      });
    });
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn) {
      Get.find<SearchController>().getSuggestedFoods();
    }
    Get.find<SearchController>().getHistoryList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // final TextEditingController c = TextEditingController.fromValue(
    //     new TextEditingValue(
    //         text: name,
    //         selection: new TextSelection.collapsed(
    //             offset: name.length)));
    return WillPopScope(
      onWillPop: () async {
        if (Get.find<SearchController>().isSearchMode) {
          return true;
        } else {
          Get.find<SearchController>().setSearchMode(true);
          return false;
        }
      },
      child: Scaffold(
        appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
        body: SafeArea(
            child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
          child: GetBuilder<SearchController>(builder: (searchController) {
            // _searchController.text = searchController.searchText;
            return Column(children: [
              Center(
                  child: SizedBox(
                      width: Dimensions.WEB_MAX_WIDTH,
                      child: Row(children: [
                        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                        Expanded(
                            child:TextField(
                              controller: _searchController,
                              // key: _orderFormKey,
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                hintText: 'search_food_or_restaurant'.tr,
                                hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), borderSide: BorderSide.none),
                                fillColor: Theme.of(context).cardColor,

                                suffixIcon: IconButton(
                                  icon: Icon(!searchController.isSearchMode
                                      ? Icons.filter_list
                                      : Icons.search,),
                                ),
                              ),
                              onChanged: (text) {

                                _actionSearch(searchController, true);

                              }
                                  ,
                            ) ),
                        CustomButton(
                          onPressed: () => searchController.isSearchMode
                              ? Get.back()
                              : searchController.setSearchMode(true),
                          buttonText: 'cancel'.tr,
                          transparent: true,
                          width: 80,
                        ),
                      ]))),
              SizedBox(height: 50,),
              Expanded(
                  child: searchController.isSearchMode
                      ? SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL),
                          child: Center(
                              child: SizedBox(
                                  width: Dimensions.WEB_MAX_WIDTH,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        searchController.historyList.length > 0
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                    Text('history'.tr,
                                                        style: robotoMedium.copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeLarge)),
                                                    InkWell(
                                                      onTap: () => searchController
                                                          .clearSearchAddress(),
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            vertical: Dimensions
                                                                .PADDING_SIZE_SMALL,
                                                            horizontal: 4),
                                                        child: Text(
                                                            'clear_all'.tr,
                                                            style: robotoRegular
                                                                .copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall,
                                                              color: Theme.of(
                                                                      context)
                                                                  .disabledColor,
                                                            )),
                                                      ),
                                                    ),
                                                  ])
                                            : SizedBox(),
                                        ListView.builder(
                                          itemCount: searchController
                                              .historyList.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Column(children: [
                                              Row(children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () => searchController
                                                        .searchData(
                                                            searchController
                                                                    .historyList[
                                                                index]),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: Dimensions
                                                              .PADDING_SIZE_EXTRA_SMALL),
                                                      child: Text(
                                                        searchController
                                                            .historyList[index],
                                                        style: robotoRegular
                                                            .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .disabledColor),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => searchController
                                                      .removeHistory(index),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions
                                                            .PADDING_SIZE_EXTRA_SMALL),
                                                    child: Icon(Icons.close,
                                                        color: Theme.of(context)
                                                            .disabledColor,
                                                        size: 20),
                                                  ),
                                                )
                                              ]),
                                              index !=
                                                      searchController
                                                              .historyList
                                                              .length -
                                                          1
                                                  ? Divider()
                                                  : SizedBox(),
                                            ]);
                                          },
                                        ),
                                        SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_LARGE),
                                        (_isLoggedIn &&
                                                searchController
                                                        .suggestedFoodList !=
                                                    null)
                                            ? Text(
                                                'suggestions'.tr,
                                                style: robotoMedium.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeLarge),
                                              )
                                            : SizedBox(),
                                        SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        GridView.builder(
                                          gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                            ResponsiveHelper
                                                .isMobile(
                                                context)
                                                ? 3
                                                : 4,
                                            childAspectRatio:
                                            (1 / 0.4),
                                            mainAxisSpacing: Dimensions
                                                .PADDING_SIZE_SMALL,
                                            crossAxisSpacing: Dimensions
                                                .PADDING_SIZE_SMALL,
                                          ),
                                          physics:
                                          NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:Get.find<CategoryController>().categoryList.length,
                                          itemBuilder:
                                              (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Get.toNamed(RouteHelper.getCategoryProductRoute(
                                                  Get.find<CategoryController>().categoryList[index].id, Get.find<CategoryController>().categoryList[index].name,
                                                ));
                                              },
                                              child: Container(
                                                decoration:
                                                BoxDecoration(
                                                  color: Theme.of(
                                                      context)
                                                      .cardColor,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .RADIUS_SMALL),
                                                ),
                                                child: Row(children: [
                                                  SizedBox(
                                                      width: Dimensions
                                                          .PADDING_SIZE_SMALL),
                                                  // ClipRRect(
                                                  //   borderRadius:
                                                  //   BorderRadius.circular(
                                                  //       Dimensions
                                                  //           .RADIUS_SMALL),
                                                  //   child:
                                                  //   CustomImage(
                                                  //     image: '${Get.find<SplashController>().configModel.baseUrls.categoryImageUrl}/${ Get.find<CategoryController>().categoryList[index].image}',
                                                  //     width: 45,
                                                  //     height: 45,
                                                  //     fit: BoxFit
                                                  //         .cover,
                                                  //   ),
                                                  // ),
                                                  // SizedBox(
                                                  //     width: Dimensions
                                                  //         .PADDING_SIZE_SMALL),
                                                  Text(
                                                    Get.find<CategoryController>().categoryList[index].name,
                                                    style: robotoMedium
                                                        .copyWith(
                                                        fontSize:
                                                        Dimensions
                                                            .fontSizeSmall),
                                                    maxLines: 2,
                                                    overflow:
                                                    TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ]),
                                              ),
                                            );
                                          },
                                        ),
                                      ]))),
                        )
                      : SearchResultWidget(
                          searchText: _searchController.text.trim())),
            ]);
          }),
        )),
      ),
    );
  }

  void _actionSearch(SearchController searchController, bool isSubmit) {
    if (searchController.isSearchMode || isSubmit) {
      if (_searchController.text.trim().isNotEmpty) {
        searchController.searchData(_searchController.text.trim());
      } else {
        showCustomSnackBar('search_food_or_restaurant'.tr);
      }
    } else {
      List<double> _prices = [];
      if (!searchController.isRestaurant) {
        searchController.allProductList
            .forEach((product) => _prices.add(product.price));
        _prices.sort();
      }
      double _maxValue =
          _prices.length > 0 ? _prices[_prices.length - 1] : 1000;
      Get.dialog(FilterWidget(
          maxValue: _maxValue, isRestaurant: searchController.isRestaurant));
    }
  }
}
