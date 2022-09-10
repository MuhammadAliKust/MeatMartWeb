import 'package:efood_multivendor/controller/category_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/screens/home/widget/category_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CategoryView1 extends StatelessWidget {

  List<String> categoryImages = [
    "assets/image/chicken.png",
    "assets/image/goat.png",
    "assets/image/fish.png",
    "assets/image/piece.png",
    "assets/image/kekra.png",
    "assets/image/6.png",
    "assets/image/fry.png",

    "assets/image/8.png",
    "assets/image/9.png",
    "assets/image/egg.png",
    "assets/image/eat.png",
    "assets/image/bengali.png",
    // "assets/image/c.png",
  ];
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return GetBuilder<CategoryController>(builder: (categoryController) {
      return (categoryController.categoryList != null &&
              categoryController.categoryList.length == 0)
          ? SizedBox()
          : Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 95,
                        child: categoryController.categoryList != null
                            ? ListView.builder(
                                controller: _scrollController,
                                itemCount:
                                    categoryController.categoryList.length > 12
                                        ? 12
                                        : categoryController
                                            .categoryList.length,
                                padding: EdgeInsets.only(
                                    left: Dimensions.PADDING_SIZE_SMALL),
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 10),
                                        child: InkWell(
                                          onTap: () => Get.toNamed(RouteHelper
                                              .getCategoryProductRoute(
                                            categoryController
                                                .categoryList[index].id,
                                            categoryController
                                                .categoryList[index].name,
                                          )),
                                          child: SizedBox(
                                            width: 75,
                                            child: Container(
                                              height: 65,
                                              width: 65,
                                              margin: EdgeInsets.only(
                                                left: index == 0
                                                    ? 0
                                                    : Dimensions
                                                        .PADDING_SIZE_EXTRA_SMALL,
                                                right: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL,
                                              ),
                                              child: Stack(children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),

                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Image.asset(categoryImages[index]),
                                                  ),
                                                ),
                                                // Positioned(bottom: 0, left: 0, right: 0, child: Container(
                                                //   padding: EdgeInsets.symmetric(vertical: 2),
                                                //   decoration: BoxDecoration(
                                                //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(Dimensions.RADIUS_SMALL)),
                                                //     color: Theme.of(context).primaryColor.withOpacity(0.8),
                                                //   ),
                                                //   child: Text(
                                                //     categoryController.categoryList[index].name, maxLines: 1, overflow: TextOverflow.ellipsis,
                                                //     textAlign: TextAlign.center,
                                                //     style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Colors.white),
                                                //   ),
                                                // )),
                                              ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        categoryController
                                            .categoryList[index].name
                                            .toString(),
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  );
                                },
                              )
                            : CategoryShimmer(
                                categoryController: categoryController),
                      ),
                    ),
                    ResponsiveHelper.isMobile(context)
                        ? SizedBox()
                        : categoryController.categoryList != null
                            ? Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (con) => Dialog(
                                              child: Container(
                                                  height: 550,
                                                  width: 600,
                                                  child: CategoryPopUp(
                                                    categoryController:
                                                        categoryController,
                                                  ))));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: Dimensions.PADDING_SIZE_SMALL),
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: Text('view_all'.tr,
                                            style: TextStyle(
                                                fontSize: Dimensions
                                                    .PADDING_SIZE_DEFAULT,
                                                color: Theme.of(context)
                                                    .cardColor)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              )
                            : CategoryAllShimmer(
                                categoryController: categoryController)
                  ],
                ),
              ],
            );
    });
  }
}

class CategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;

  CategoryShimmer({@required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView.builder(
        itemCount: 14,
        padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: SizedBox(
                  width: 75,
                  child: Container(
                    height: 65,
                    width: 65,
                    margin: EdgeInsets.only(
                      left:
                          index == 0 ? 0 : Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                    ),
                    child: Shimmer(
                      duration: Duration(seconds: 2),
                      enabled: categoryController.categoryList == null,
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CategoryAllShimmer extends StatelessWidget {
  final CategoryController categoryController;

  CategoryAllShimmer({@required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Padding(
        padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
        child: Shimmer(
          duration: Duration(seconds: 2),
          enabled: categoryController.categoryList == null,
          child: Column(children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              ),
            ),
            SizedBox(height: 5),
            Container(height: 10, width: 50, color: Colors.grey[300]),
          ]),
        ),
      ),
    );
  }
}
