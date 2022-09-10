import 'package:efood_multivendor/controller/product_controller.dart';
import 'package:efood_multivendor/controller/theme_controller.dart';
import 'package:efood_multivendor/data/model/response/product_model.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/base/product_bottom_sheet.dart';
import 'package:efood_multivendor/view/base/rating_bar.dart';
import 'package:efood_multivendor/view/base/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../helper/price_converter.dart';
import '../../../../util/styles.dart';
import '../../../base/custom_image.dart';
import 'best_reviewed_item_view.dart';

class PopularItemView1 extends StatelessWidget {
  final bool isPopular;

  PopularItemView1({@required this.isPopular});

  @override
  Widget build(BuildContext context) {
    bool _desktop = ResponsiveHelper.isDesktop(context);
    return GetBuilder<ProductController>(builder: (productController) {
      List<Product> _productList = isPopular
          ? productController.popularProductList
          : productController.reviewedProductList;

      return (_productList != null && _productList.length == 0)
          ? SizedBox()
          : Column(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: TitleWidget(
                  title: isPopular
                      ? 'Premium Items'.tr
                      : 'best_reviewed_food'.tr,
                  onTap: () =>
                      Get.toNamed(RouteHelper.getPopularFoodRoute(isPopular)),
                ),
              ),
              SizedBox(
                child: _productList != null
                    ? ListView.builder(
                        controller: ScrollController(),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(
                            left: Dimensions.PADDING_SIZE_SMALL),
                        itemCount:
                            _productList.length > 50 ? 50 : _productList.length,
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
                                child: Card(
                                  elevation: 3,
                                  child: Container(
                                    height: 110,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.RADIUS_SMALL),
                                            child: CustomImage(
                                              image: _productList[index]
                                                  .image
                                                  .toString(),
                                              height: _desktop ? 120 : 100,
                                              width: _desktop ? 120 : 120,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),

                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _productList[index].name,
                                                  style: robotoMedium.copyWith(
                                                      fontSize: 15),
                                                  // maxLines: _desktop ? 2 : 1, overflow: TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                RatingBar(
                                                  rating: _productList[index]
                                                      .avgRating,
                                                  size: _desktop ? 15 : 12,
                                                  ratingCount: _productList[index]
                                                      .ratingCount,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(children: [
                                                  Text(
                                                    PriceConverter.convertPrice(
                                                        _productList[index].price,
                                                        discount:
                                                            _productList[index]
                                                                .discount,
                                                        discountType:
                                                            _productList[index]
                                                                .discountType),
                                                    style: robotoMedium.copyWith(
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                      width: _productList[index]
                                                                  .discount >
                                                              0
                                                          ? Dimensions
                                                              .PADDING_SIZE_EXTRA_SMALL
                                                          : 0),
                                                  _productList[index].discount > 0
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
                                                  SizedBox(
                                                      width: Dimensions
                                                          .PADDING_SIZE_EXTRA_SMALL),
                                                ]),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                // Container(
                                //   height: 220,
                                //   width: 180,
                                //   decoration: BoxDecoration(
                                //     color: Theme.of(context).cardColor,
                                //     borderRadius: BorderRadius.circular(
                                //         Dimensions.RADIUS_SMALL),
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.grey[
                                //             Get.find<ThemeController>().darkTheme
                                //                 ? 800
                                //                 : 300],
                                //         blurRadius: 5,
                                //         spreadRadius: 1,
                                //       )
                                //     ],
                                //   ),
                                //   child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.start,
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       children: [
                                //         Stack(children: [
                                //           ClipRRect(
                                //             borderRadius: BorderRadius.vertical(
                                //                 top: Radius.circular(
                                //                     Dimensions.RADIUS_SMALL)),
                                //             child: CustomImage(
                                //               image:
                                //                   '${Get.find<SplashController>().configModel.baseUrls.productImageUrl}/${_productList[index].image}',
                                //               height: 125,
                                //               // width: 170,
                                //               fit: BoxFit.cover,
                                //             ),
                                //           ),
                                //           DiscountTag(
                                //             discount:
                                //                 _productList[index].discount,
                                //             discountType:
                                //                 _productList[index].discountType,
                                //             inLeft: false,
                                //           ),
                                //           productController.isAvailable(
                                //                   _productList[index])
                                //               ? SizedBox()
                                //               : NotAvailableWidget(
                                //                   isRestaurant: true),
                                //           Positioned(
                                //             top: Dimensions
                                //                 .PADDING_SIZE_EXTRA_SMALL,
                                //             left: Dimensions
                                //                 .PADDING_SIZE_EXTRA_SMALL,
                                //             child: Container(
                                //               padding: EdgeInsets.symmetric(
                                //                   vertical: 2,
                                //                   horizontal: Dimensions
                                //                       .PADDING_SIZE_EXTRA_SMALL),
                                //               decoration: BoxDecoration(
                                //                 color: Theme.of(context)
                                //                     .cardColor
                                //                     .withOpacity(0.8),
                                //                 borderRadius:
                                //                     BorderRadius.circular(
                                //                         Dimensions.RADIUS_SMALL),
                                //               ),
                                //               child: Row(children: [
                                //                 Icon(Icons.star,
                                //                     color: Theme.of(context)
                                //                         .primaryColor,
                                //                     size: 15),
                                //                 SizedBox(
                                //                     width: Dimensions
                                //                         .PADDING_SIZE_EXTRA_SMALL),
                                //                 Text(
                                //                     _productList[index]
                                //                         .avgRating
                                //                         .toStringAsFixed(1),
                                //                     style: robotoRegular),
                                //               ]),
                                //             ),
                                //           ),
                                //         ]),
                                //         Expanded(
                                //           child: Stack(children: [
                                //             Padding(
                                //               padding: EdgeInsets.symmetric(
                                //                   horizontal: Dimensions
                                //                       .PADDING_SIZE_EXTRA_SMALL),
                                //               child: Column(
                                //                   mainAxisAlignment:
                                //                       MainAxisAlignment.center,
                                //                   crossAxisAlignment:
                                //                       CrossAxisAlignment.start,
                                //                   children: [
                                //                     Text(
                                //                       _productList[index].name ??
                                //                           '',
                                //                       textAlign: TextAlign.center,
                                //                       style:
                                //                           robotoMedium.copyWith(
                                //                               fontSize: Dimensions
                                //                                   .fontSizeSmall),
                                //                       maxLines: 2,
                                //                       overflow:
                                //                           TextOverflow.ellipsis,
                                //                     ),
                                //                     SizedBox(height: 2),
                                //                     // Text(
                                //                     //   _productList[index]
                                //                     //           .restaurantName ??
                                //                     //       '',
                                //                     //   textAlign: TextAlign.center,
                                //                     //   style: robotoMedium.copyWith(
                                //                     //       fontSize: Dimensions
                                //                     //           .fontSizeExtraSmall,
                                //                     //       color: Theme.of(context)
                                //                     //           .disabledColor),
                                //                     //   maxLines: 1,
                                //                     //   overflow:
                                //                     //       TextOverflow.ellipsis,
                                //                     // ),
                                //                     SizedBox(
                                //                         height: Dimensions
                                //                             .PADDING_SIZE_EXTRA_SMALL),
                                //                     Row(
                                //                         mainAxisAlignment:
                                //                             MainAxisAlignment
                                //                                 .start,
                                //                         crossAxisAlignment:
                                //                             CrossAxisAlignment
                                //                                 .start,
                                //                         children: [
                                //                           productController.getDiscount(
                                //                                       _productList[
                                //                                           index]) >
                                //                                   0
                                //                               ? Flexible(
                                //                                   child: Text(
                                //                                   PriceConverter.convertPrice(
                                //                                       productController
                                //                                           .getStartingPrice(
                                //                                               _productList[index])),
                                //                                   style:
                                //                                       robotoRegular
                                //                                           .copyWith(
                                //                                     fontSize:
                                //                                         Dimensions
                                //                                             .fontSizeExtraSmall,
                                //                                     color: Theme.of(
                                //                                             context)
                                //                                         .errorColor,
                                //                                     decoration:
                                //                                         TextDecoration
                                //                                             .lineThrough,
                                //                                   ),
                                //                                 ))
                                //                               : SizedBox(),
                                //                           SizedBox(
                                //                               width: _productList[
                                //                                               index]
                                //                                           .discount >
                                //                                       0
                                //                                   ? Dimensions
                                //                                       .PADDING_SIZE_EXTRA_SMALL
                                //                                   : 0),
                                //                           Text(
                                //                             PriceConverter
                                //                                 .convertPrice(
                                //                               productController
                                //                                   .getStartingPrice(
                                //                                       _productList[
                                //                                           index]),
                                //                               discount: productController
                                //                                   .getDiscount(
                                //                                       _productList[
                                //                                           index]),
                                //                               discountType: productController
                                //                                   .getDiscountType(
                                //                                       _productList[
                                //                                           index]),
                                //                             ),
                                //                             style: robotoMedium,
                                //                           ),
                                //                         ]),
                                //                   ]),
                                //             ),
                                //           ]),
                                //         ),
                                //       ]),
                                // ),
                                ),
                          );
                        },
                      )
                    : BestReviewedItemShimmer(
                        productController: productController),
              ),
            ]);
    });
  }
}

class PopularItemShimmer extends StatelessWidget {
  final bool enabled;

  PopularItemShimmer({@required this.enabled});

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
          padding: EdgeInsets.fromLTRB(2, 2, Dimensions.PADDING_SIZE_SMALL, 2),
          child: Container(
            height: 90,
            width: 250,
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
              duration: Duration(seconds: 1),
              interval: Duration(seconds: 1),
              enabled: enabled,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        color: Colors.grey[300],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 15,
                                  width: 100,
                                  color: Colors.grey[300]),
                              SizedBox(height: 5),
                              Container(
                                  height: 10,
                                  width: 130,
                                  color: Colors.grey[300]),
                              SizedBox(height: 5),
                              RatingBar(rating: 0, size: 12, ratingCount: 0),
                              Row(children: [
                                Expanded(
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                            width: Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                        Container(
                                            height: 10,
                                            width: 40,
                                            color: Colors.grey[300]),
                                        Container(
                                            height: 15,
                                            width: 40,
                                            color: Colors.grey[300]),
                                      ]),
                                ),
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor),
                                  child: Icon(Icons.add,
                                      size: 20, color: Colors.white),
                                ),
                              ]),
                            ]),
                      ),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
