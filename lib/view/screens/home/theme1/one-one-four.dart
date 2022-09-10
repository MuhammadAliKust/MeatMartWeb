import 'package:efood_multivendor/controller/one-one-four.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/theme_controller.dart';
import 'package:efood_multivendor/data/model/response/product_model.dart';
import 'package:efood_multivendor/helper/price_converter.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/discount_tag.dart';
import 'package:efood_multivendor/view/base/product_bottom_sheet.dart';
import 'package:efood_multivendor/view/base/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../controller/category_controller.dart';
import '../../../../controller/mutton.dart';

class OneOneFourCategory extends StatefulWidget {
  @override
  State<OneOneFourCategory> createState() => _OneOneFourCategoryState();
}

class _OneOneFourCategoryState extends State<OneOneFourCategory> {
  @override
  void initState() {
    super.initState();
    Get.find<CategoryController>().getCategoryList(false);
    Get.find<OneOneFourController>().getSubCategoryList('2');
  }
  String categoryName = "";
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (list){
      list.categoryList.forEach((f) {
        if (f.id == 2) {
          categoryName = f.name;
        }
      });
      return GetBuilder<OneOneFourController>(builder: (catController) {
        List<Product> _productList = catController.categoryProductList;

        return (_productList != null && _productList.length == 0)
            ? SizedBox()
            : Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
              child: TitleWidget(
                title:categoryName,
                onTap: () => Get.toNamed(
                    RouteHelper.getCategoryProductRoute(
                        2, categoryName)),
              ),
            ),
            SizedBox(
              height: 220,
              child: _productList != null
                  ? ListView.builder(
                controller: ScrollController(),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(
                    left: Dimensions.PADDING_SIZE_SMALL),
                itemCount: _productList.length > 10
                    ? 10
                    : _productList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        right: Dimensions.PADDING_SIZE_SMALL,
                        bottom: 5),
                    child: InkWell(
                      onTap: () {
                        ResponsiveHelper.isMobile(context)
                            ? Get.bottomSheet(
                          ProductBottomSheet(
                              product: _productList[index],
                              isCampaign: false),
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                        )
                            : Get.dialog(
                          Dialog(
                              child: ProductBottomSheet(
                                  product:
                                  _productList[index])),
                        );
                      },
                      child: Container(
                        height: 220,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(
                              Dimensions.RADIUS_SMALL),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[
                              Get.find<ThemeController>()
                                  .darkTheme
                                  ? 800
                                  : 300],
                              blurRadius: 5,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Stack(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(
                                          Dimensions.RADIUS_SMALL)),
                                  child: CustomImage(
                                    image:
                                    '${Get.find<SplashController>().configModel.baseUrls.productImageUrl}/${_productList[index].image}',
                                    height: 125,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                DiscountTag(
                                  discount:
                                  _productList[index].discount,
                                  discountType: _productList[index]
                                      .discountType,
                                  inLeft: false,
                                ),
                                Positioned(
                                  top: Dimensions
                                      .PADDING_SIZE_EXTRA_SMALL,
                                  left: Dimensions
                                      .PADDING_SIZE_EXTRA_SMALL,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .cardColor
                                          .withOpacity(0.8),
                                      borderRadius:
                                      BorderRadius.circular(
                                          Dimensions
                                              .RADIUS_SMALL),
                                    ),
                                    child: Row(children: [
                                      Icon(Icons.star,
                                          color: Theme.of(context)
                                              .primaryColor,
                                          size: 15),
                                      SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Text(
                                          _productList[index]
                                              .avgRating
                                              .toStringAsFixed(1),
                                          style: robotoRegular),
                                    ]),
                                  ),
                                ),
                              ]),
                              Expanded(
                                child: Stack(children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _productList[index]
                                                .name ??
                                                '',
                                            textAlign:
                                            TextAlign.start,
                                            style: robotoMedium.copyWith(
                                                fontSize: Dimensions
                                                    .fontSizeSmall),
                                            maxLines: 2,
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 2),
                                          // Text(
                                          //   _productList[index]
                                          //           .restaurantName ??
                                          //       '',
                                          //   textAlign:
                                          //       TextAlign.center,
                                          //   style: robotoMedium.copyWith(
                                          //       fontSize: Dimensions
                                          //           .fontSizeExtraSmall,
                                          //       color: Theme.of(
                                          //               context)
                                          //           .disabledColor),
                                          //   maxLines: 1,
                                          //   overflow:
                                          //       TextOverflow.ellipsis,
                                          // ),
                                          SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          Text(
                                            PriceConverter.convertPrice(
                                                _productList[index]
                                                    .price,
                                                discount:
                                                _productList[
                                                index]
                                                    .discount,
                                                discountType:
                                                _productList[
                                                index]
                                                    .discountType),
                                            style:
                                            robotoMedium.copyWith(
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                              width: _productList[
                                              index]
                                                  .discount >
                                                  0
                                                  ? Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL
                                                  : 0),

                                          _productList[index]
                                              .discount >
                                              0
                                              ? Text(
                                            PriceConverter
                                                .convertPrice(
                                                _productList[
                                                index]
                                                    .price),
                                            style: robotoMedium
                                                .copyWith(
                                              fontSize: Dimensions
                                                  .fontSizeSmall,
                                              color: Theme.of(
                                                  context)
                                                  .disabledColor,
                                              decoration:
                                              TextDecoration
                                                  .lineThrough,
                                            ),
                                          )
                                              : SizedBox(),
                                          // Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment
                                          //             .start,
                                          //     crossAxisAlignment:
                                          //         CrossAxisAlignment
                                          //             .start,
                                          //     children: [
                                          //       productController.getDiscount(
                                          //                   _productList[
                                          //                       index]) >
                                          //               0
                                          //           ? Flexible(
                                          //               child: Text(
                                          //               PriceConverter.convertPrice(
                                          //                   productController
                                          //                       .getStartingPrice(
                                          //                           _productList[index])),
                                          //               style: robotoRegular
                                          //                   .copyWith(
                                          //                 fontSize:
                                          //                     Dimensions
                                          //                         .fontSizeExtraSmall,
                                          //                 color: Theme.of(
                                          //                         context)
                                          //                     .errorColor,
                                          //                 decoration:
                                          //                     TextDecoration
                                          //                         .lineThrough,
                                          //               ),
                                          //             ))
                                          //           : SizedBox(),
                                          //       SizedBox(
                                          //           width: _productList[
                                          //                           index]
                                          //                       .discount >
                                          //                   0
                                          //               ? Dimensions
                                          //                   .PADDING_SIZE_EXTRA_SMALL
                                          //               : 0),
                                          //       Text(
                                          //         PriceConverter
                                          //             .convertPrice(
                                          //           productController
                                          //               .getStartingPrice(
                                          //                   _productList[
                                          //                       index]),
                                          //           discount: productController
                                          //               .getDiscount(
                                          //                   _productList[
                                          //                       index]),
                                          //           discountType: productController
                                          //               .getDiscountType(
                                          //                   _productList[
                                          //                       index]),
                                          //         ),
                                          //         style: robotoMedium,
                                          //       ),
                                          //     ]),
                                        ]),
                                  ),
                                ]),
                              ),
                            ]),
                      ),
                    ),
                  );
                },
              )
                  : BestReviewedItemShimmer(
                list: _productList,
              ),
            ),
            SizedBox(height: 10,)
          ],
        );
      });
    });

  }
}

class BestReviewedItemShimmer extends StatelessWidget {
  final List list;

  BestReviewedItemShimmer({@required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding:
              EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
          child: Container(
            height: 220,
            width: 180,
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              boxShadow: [
                BoxShadow(
                  color: Colors
                      .grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                  blurRadius: 5,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Shimmer(
              duration: Duration(seconds: 2),
              enabled: true,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(children: [
                      Container(
                        height: 125,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(Dimensions.RADIUS_SMALL)),
                          color: Colors.grey[300],
                        ),
                      ),
                      Positioned(
                        top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor.withOpacity(0.8),
                            borderRadius:
                                BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          ),
                          child: Row(children: [
                            Icon(Icons.star,
                                color: Theme.of(context).primaryColor,
                                size: 15),
                            SizedBox(
                                width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            Text('0.0', style: robotoRegular),
                          ]),
                        ),
                      ),
                    ]),
                    Expanded(
                      child: Stack(children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                    height: 15,
                                    width: 100,
                                    color: Colors.grey[300]),
                                SizedBox(height: 2),
                                Container(
                                    height: 10,
                                    width: 70,
                                    color: Colors.grey[300]),
                                SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                          height: 10,
                                          width: 40,
                                          color: Colors.grey[300]),
                                      SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Container(
                                          height: 15,
                                          width: 40,
                                          color: Colors.grey[300]),
                                    ]),
                              ]),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor),
                              child: Icon(Icons.add,
                                  size: 20, color: Colors.white),
                            )),
                      ]),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
