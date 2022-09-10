import 'dart:async';
import 'dart:convert';

import 'package:better_player/better_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:efood_multivendor/controller/location_controller.dart';
import 'package:efood_multivendor/controller/notification_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/screens/blogs/blog_view.dart';
import 'package:efood_multivendor/view/screens/home/theme1/banner_view1.dart';
import 'package:efood_multivendor/view/screens/home/theme1/category_view1.dart';
import 'package:efood_multivendor/view/screens/home/theme1/item_campaign_view1.dart';
import 'package:efood_multivendor/view/screens/home/theme1/nine-two-category.dart';
import 'package:efood_multivendor/view/screens/home/theme1/one-one-eight.dart';
import 'package:efood_multivendor/view/screens/home/theme1/one-one-four.dart';
import 'package:efood_multivendor/view/screens/slider_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marquee/marquee.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import '../../../../controller/category_controller.dart';
import '../../../../controller/splash_controller.dart';
import '../../../base/custom_image.dart';
import '../../../base/title_widget.dart';
import '../../blogs/post_details.dart';
import '../web/widgets/four.dart';
import '../web/widgets/one-one-seven.dart';
import '../web/widgets/one_category.dart';
import '../web/widgets/two.dart';
import '../widget/top_deals.dart';
import 'combo_deal.dart';
import 'one-one-nine.dart';
import 'one-two-two.dart';
import 'one-two-zero.dart';

class Theme1HomeScreen extends StatefulWidget {
  final ScrollController scrollController;

  VideoPlayerController _controller1;

  Theme1HomeScreen(this._controller1, {@required this.scrollController});

  @override
  State<Theme1HomeScreen> createState() => _Theme1HomeScreenState();
}

class _Theme1HomeScreenState extends State<Theme1HomeScreen> {
  final Completer<WebViewController> _controllerWeb =
  Completer<WebViewController>();
  void registerWebViewWebImplementation() {
    WebView.platform = WebWebViewPlatform();
  }
  Future<List> fetchWpPosts() async {
    http.Response _response = await http.get(
        Uri.parse(
            "https://blog.bigmeatmart.com/wp-json/wp/v2/posts?categories=4"),
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/json; charset=UTF-8',
        }).timeout(Duration(seconds: 30));
    var convertDatatoJson = jsonDecode(_response.body);
    return convertDatatoJson;

    // final response = await http.get(
    //     Uri.parse(
    //         "https://blog.bigmeatmart.com/wp-json/wp/v2/posts?categories=4"),
    //   );
    //
    // var convertDatatoJson = jsonDecode(response.body);
    // return convertDatatoJson;
  }

  Future<List> fetchBottomList() async {
    final response = await http.get(
        Uri.parse(
            "https://blog.bigmeatmart.com/wp-json/wp/v2/posts?categories=3"),
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/json; charset=UTF-8',
        });

    var convertDatatoJson = jsonDecode(response.body);
    return convertDatatoJson;
  }

  Future<List> fetchMarqueeData() async {
    final response = await http.get(
        Uri.parse(
            "https://blog.bigmeatmart.com/wp-json/wp/v2/posts?categories=5"),
        headers: {
          "Content-Type": "application/json",
          "charset": "UTF-8",
          "zoneId": "[1]",
          "X-localization": "en",
          "Authorization": "Bearer null"
        });

    print("Response : $response");
    var convertDatatoJson = jsonDecode(response.body);
    return convertDatatoJson;
  }

  VideoPlayerController _controller;
  VideoPlayerController _controller1;

  ChewieController _chewieController;
  ChewieController _chewieController1;

  @override
  void initState() {
    WebView.platform = WebWebViewPlatform();

    // _controller = VideoPlayerController.network(
    //     'https://k135.github.io/bigmeatmart/del.mp4',
    //     videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
    _controller1 = VideoPlayerController.network(
        'https://k135.github.io/bigmeatmart/bigme.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    // _headerController.addListener(() {
    //   if (_headerController.position.pixels >= 500) {
    //    showHeader = true;
    //    setState((){});
    //   }else{
    //     showHeader = false;
    //     setState((){});
    //   }
    // });
    super.initState();
  }

  bool showHeader = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _controller1.dispose();
    _chewieController.dispose();
    _chewieController1.dispose();

    super.dispose();
  }

  ScrollController _headerController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // print(_controller.value.isPlaying);
    // print(_headerController.position.pixels);
    // print(_headerController.position.maxScrollExtent);
    return SingleChildScrollView(
      controller: _headerController,
      child: StickyHeader(
        header: showHeader
            ? Container(color: Colors.white, child: CategoryView1())
            : SizedBox(),
        content: Column(
          children: [
            // App Bar
            AppBar(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).primaryColor,
              title: Center(
                  child: Container(
                width: Dimensions.WEB_MAX_WIDTH,
                height: 50,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(children: [
                  Expanded(
                      child: InkWell(
                    onTap: () =>
                        Get.toNamed(RouteHelper.getAccessLocationRoute('home')),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_SMALL,
                        horizontal: ResponsiveHelper.isDesktop(context)
                            ? Dimensions.PADDING_SIZE_SMALL
                            : 0,
                      ),
                      child: GetBuilder<LocationController>(
                          builder: (locationController) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              locationController.getUserAddress().addressType ==
                                      'home'
                                  ? Icons.home_filled
                                  : locationController
                                              .getUserAddress()
                                              .addressType ==
                                          'office'
                                      ? Icons.work
                                      : Icons.location_on,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                locationController.getUserAddress().address,
                                style: robotoRegular.copyWith(
                                  color: Colors.white,
                                  fontSize: Dimensions.fontSizeSmall,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ],
                        );
                      }),
                    ),
                  )),
                  InkWell(
                    child: GetBuilder<NotificationController>(
                        builder: (notificationController) {
                      return Stack(children: [
                        Icon(
                          Icons.notifications,
                          size: 25,
                          color: Colors.white,
                        ),
                        notificationController.hasNotification
                            ? Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                            : SizedBox(),
                      ]);
                    }),
                    onTap: () =>
                        Get.toNamed(RouteHelper.getNotificationRoute()),
                  ),
                ]),
              )),
              actions: [SizedBox()],
            ),

            // CategoryView1(),
            // Search Button

            Center(
                child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BannerView1(),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/image/b1.png'),
                                fit: BoxFit.cover)),
                        height: 120,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, right: 18, top: 25, bottom: 0),
                              child: InkWell(
                                onTap: () =>
                                    Get.toNamed(RouteHelper.getSearchRoute()),
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.PADDING_SIZE_SMALL),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x1a943234),
                                          spreadRadius: 10,
                                          blurRadius: 10)
                                    ],
                                  ),
                                  child: Row(children: [
                                    SizedBox(
                                        width: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    Icon(
                                      Icons.search,
                                      size: 25,
                                      color: Theme.of(context).hintColor,
                                    ),
                                    SizedBox(
                                        width: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    Expanded(
                                        child: Text(
                                      'Search : Chicken | Mutton | Fish'.tr,
                                      style: robotoRegular.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    )),
                                  ]),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // FutureBuilder(
                            //   future: fetchMarqueeData(),
                            //   builder: (context, snapshot) {
                            //     print("snapshot.data : ${snapshot.data}");
                            //     if (snapshot.hasData) {
                            //       print(snapshot.data.length.toString() +
                            //           "Length");
                            //       return Container(
                            //         height: 30,
                            //         width: double.infinity,
                            //         color: Theme.of(context).primaryColor,
                            //         child: Padding(
                            //             padding: const EdgeInsets.symmetric(
                            //                 horizontal: 12.0),
                            //             child: Marquee(
                            //                 text: snapshot.data[0]['title']
                            //                     ['rendered'],
                            //                 scrollAxis: Axis.horizontal,
                            //                 style: TextStyle(
                            //                     color: Colors.white,
                            //                     fontWeight: FontWeight.bold))),
                            //       );
                            //     }
                            //
                            //     return Center(
                            //         child: CircularProgressIndicator());
                            //   },
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    CategoryView1(),
                    SizedBox(
                      height: 10,
                    ),
                    //
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 12.0,
                    //   ),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(12),
                    //     child: Container(
                    //         width:MediaQuery.of(context).size.width,
                    //         // color: Colors.blue,
                    //         height: 177,
                    //         child: AspectRatio(
                    //           aspectRatio: _controller1.value.aspectRatio,
                    //           child: VideoPlayer(
                    //             _controller1,
                    //           ),
                    //         )),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child:Image.network(
                          'https://blog.bigmeatmart.com/wp-content/uploads/2022/08/Frame-1-41-1024x170.png',
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemCampaignView1(),

                    FourCategory(),
                    SizedBox(
                      height: 8,
                    ),
                    OneCategory(),
                    SizedBox(
                      height: 8,
                    ), TwoCategory(),
                    SizedBox(
                      height: 8,
                    ),
                    ComboDealWidget(),
                    // SizedBox(height: 20),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 12.0,
                    //   ),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(12),
                    //     child: Image.asset('assets/image/driver.jpeg'),
                    //   ),
                    // ),

                    SizedBox(
                      height: 10,
                    ),   OneTwoTwoCategory(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/image/b2.png'),
                              fit: BoxFit.cover)),
                      child: GetBuilder<CategoryController>(
                          builder: (categoryController) {
                        return (categoryController.categoryList != null &&
                                categoryController.categoryList.length == 0)
                            ? SizedBox()
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                      child: Text(
                                    "Categories",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 150,
                                              childAspectRatio: 1,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10),
                                      itemCount: categoryController
                                                  .categoryList.length >
                                              15
                                          ? 15
                                          : categoryController
                                              .categoryList.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.toNamed(RouteHelper
                                                .getCategoryProductRoute(
                                              categoryController
                                                  .categoryList[index].id,
                                              categoryController
                                                  .categoryList[index].name,
                                            ));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: CustomImage(
                                              image:
                                                  '${Get.find<SplashController>().configModel.baseUrls.categoryImageUrl}/${categoryController.categoryList[index].image}',
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              // height: 120,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                      }),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          width: double.infinity,
                          child: Image.asset(
                            'assets/image/b3.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    TopDealsWidget(),

                    // Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(12),
                    //     child: Container(
                    //       height: 120,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(12)),
                    //       width: double.infinity,
                    //       child: Image.asset(
                    //         'assets/image/b3.jpeg',
                    //         fit: BoxFit.fill,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // ItemCampaignView1(),
                    // NearByWidget(
                    //   categoryName: 'Premium Chicken',
                    //   categoryID: '1',
                    // ),

                    OneOneEightCategory(),

                    OneOneNineCategory(),


                    SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         image: AssetImage(
                    //           "assets/image/slider_blog.png",
                    //         ),
                    //         fit: BoxFit.cover),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       SizedBox(height: 20),
                    //       Padding(
                    //         padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    //         child: TitleWidget(
                    //             title: "Latest Blogs".tr,
                    //             onTap: () {
                    //               Get.to(() => BlogView());
                    //             }),
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       FutureBuilder(
                    //         future: fetchWpPosts(),
                    //         builder: (context, snapshot) {
                    //           if (snapshot.hasData) {
                    //             print(
                    //                 snapshot.data.length.toString() + "Length");
                    //             return Container(
                    //               height: snapshot.data.length > 3 ? 400 : 200,
                    //               child: StaggeredGrid.count(
                    //                 crossAxisCount: 4,
                    //                 mainAxisSpacing: 6,
                    //                 crossAxisSpacing: 6,
                    //                 children: [
                    //                   if (snapshot.data.length > 0)
                    //                     StaggeredGridTile.count(
                    //                       crossAxisCellCount: 2,
                    //                       mainAxisCellCount: 2,
                    //                       child: Tile(
                    //                         title: snapshot.data[0]['title']
                    //                                 ['rendered']
                    //                             .replaceAll("#038;", ""),
                    //                         description: snapshot.data[0]
                    //                             ['content']['rendered'],
                    //                         imageUrl: snapshot.data[0]['_links']
                    //                             ["wp:attachment"][0]["href"],
                    //                       ),
                    //                     ),
                    //                   if (snapshot.data.length > 1)
                    //                     StaggeredGridTile.count(
                    //                       crossAxisCellCount: 2,
                    //                       mainAxisCellCount: 2,
                    //                       child: Tile(
                    //                         title: snapshot.data[1]['title']
                    //                                 ['rendered']
                    //                             .replaceAll("#038;", ""),
                    //                         description: snapshot.data[1]
                    //                             ['content']['rendered'],
                    //                         imageUrl: snapshot.data[1]['_links']
                    //                             ["wp:attachment"][0]["href"],
                    //                       ),
                    //                     ),
                    //                   if (snapshot.data.length > 2)
                    //                     StaggeredGridTile.count(
                    //                       crossAxisCellCount: 2,
                    //                       mainAxisCellCount: 2,
                    //                       child: Tile(
                    //                         title: snapshot.data[2]['title']
                    //                                 ['rendered']
                    //                             .replaceAll("#038;", ""),
                    //                         description: snapshot.data[2]
                    //                             ['content']['rendered'],
                    //                         imageUrl: snapshot.data[2]['_links']
                    //                             ["wp:attachment"][0]["href"],
                    //                       ),
                    //                     ),
                    //                   if (snapshot.data.length > 3)
                    //                     StaggeredGridTile.count(
                    //                       crossAxisCellCount: 2,
                    //                       mainAxisCellCount: 2,
                    //                       child: Tile(
                    //                         title: snapshot.data[3]['title']
                    //                                 ['rendered']
                    //                             .replaceAll("#038;", ""),
                    //                         description: snapshot.data[3]
                    //                             ['content']['rendered'],
                    //                         imageUrl: snapshot.data[3]['_links']
                    //                             ["wp:attachment"][0]["href"],
                    //                       ),
                    //                     ),
                    //                 ],
                    //               ),
                    //             );
                    //           }
                    //
                    //           return Center(child: CircularProgressIndicator());
                    //         },
                    //       ),
                    //       SizedBox(height: 20),
                    //       FutureBuilder(
                    //         future: fetchBottomList(),
                    //         builder: (context, data) {
                    //           if (data.hasData) {
                    //             return CarouselSlider.builder(
                    //               itemCount: data.data.length,
                    //               itemBuilder: (context, index, _) {
                    //                 // return Padding(
                    //                 //   padding: const EdgeInsets.all(8.0),
                    //                 //   child: Container(height: 100,width: 100,color: Colors.blue,),
                    //                 // );
                    //                 return FutureBuilder(
                    //                     future: fetchWpPostImageUrl(
                    //                         data.data[index]['_links']
                    //                             ["wp:attachment"][0]["href"]),
                    //                     builder: (context, snapshot) {
                    //                       if (!snapshot.hasData) {
                    //                         return Center(
                    //                           child:
                    //                               CircularProgressIndicator(),
                    //                         );
                    //                       } else {
                    //                         if (snapshot.data.isNotEmpty) {
                    //                           return ClipRRect(
                    //                             borderRadius:
                    //                                 BorderRadius.circular(10),
                    //                             child: InkWell(
                    //                               onTap: () {
                    //                                 Get.to(() =>
                    //                                     SliderDetailsView(
                    //                                       title: data
                    //                                           .data[index]
                    //                                               ['title']
                    //                                               ['rendered']
                    //                                           .replaceAll(
                    //                                               "#038;", ""),
                    //                                       description:
                    //                                           data.data[index][
                    //                                                   'content']
                    //                                               ['rendered'],
                    //                                       image: data.data[
                    //                                                       index]
                    //                                                   ['_links']
                    //                                               [
                    //                                               "wp:attachment"]
                    //                                           [0]["href"],
                    //                                     ));
                    //                               },
                    //                               child: Padding(
                    //                                 padding:
                    //                                     const EdgeInsets.all(
                    //                                         8.0),
                    //                                 child: Container(
                    //                                   height: 100,
                    //                                   width: 100,
                    //                                   decoration: BoxDecoration(
                    //                                       borderRadius:
                    //                                           BorderRadius
                    //                                               .circular(10),
                    //                                       image: DecorationImage(
                    //                                           image: NetworkImage(
                    //                                               snapshot.data[
                    //                                                           0]
                    //                                                       [
                    //                                                       "guid"]
                    //                                                   [
                    //                                                   "rendered"]),
                    //                                           fit: BoxFit
                    //                                               .cover)),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           );
                    //                         } else {
                    //                           return Center(
                    //                             child:
                    //                                 CircularProgressIndicator(),
                    //                           );
                    //                         }
                    //                       }
                    //                     });
                    //               },
                    //               options: CarouselOptions(
                    //                 autoPlay: true,
                    //                 // enlargeCenterPage: true,
                    //                 disableCenter: true,
                    //                 viewportFraction: 0.79,
                    //                 autoPlayInterval: Duration(seconds: 7),
                    //                 onPageChanged: (index, reason) {
                    //                   // bannerController.setCurrentIndex(index, true);
                    //                 },
                    //               ),
                    //             );
                    //           }
                    //
                    //           return Center(child: CircularProgressIndicator());
                    //         },
                    //       ),
                    //       SizedBox(height: 20),
                    //     ],
                    //   ),
                    // )
                  ]),
            ))
          ],
        ),
      ),
    );
  }

  fetchWpPostImageUrl(url) async {
    final response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    var convertDatatoJson = jsonDecode(response.body);
    // print("Good : $convertDatatoJson");
    return convertDatatoJson;
  }
}

class Tile extends StatelessWidget {
  const Tile({
    this.imageUrl,
    this.title,
    this.description,
  });

  final String imageUrl;
  final String title;

  final String description;

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return FutureBuilder(
        future: fetchWpPostImageUrl(imageUrl),
        builder: (context, snapshot) {
          if (snapshot.data.isNotEmpty) if (snapshot.hasData) {
            print(snapshot.data);

            return InkWell(
              onTap: () {
                Get.to(() => PostDetailsView(
                      image: imageUrl,
                      title: title,
                      description: description,
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              snapshot.data[0]["guid"]["rendered"]),
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: Colors.white.withOpacity(0.7),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            title.toString().length > 40
                                ? title.toString().substring(0, 30) + "..."
                                : title.toString(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(child: Container());
        });
  }

  fetchWpPostImageUrl(url) async {
    final response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    var convertDatatoJson = jsonDecode(response.body);
    // print("Good : $convertDatatoJson");
    return convertDatatoJson;
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}
