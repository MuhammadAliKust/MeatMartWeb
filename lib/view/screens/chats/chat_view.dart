import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/user_controller.dart';

class ChatsView extends StatefulWidget {
  @override
  _ChatsViewState createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    if (Get.find<AuthController>().isLoggedIn()) {
      await Get.find<UserController>().getUserInfo();
    }
  }

  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      return MaterialApp(
        home: SafeArea(
          child: Scaffold(

              // body: Tawk(
              //
              //   directChatLink: 'https://tawk.to/chat/624161982abe5b455fc1eb0f/1fv7mafqs',
              //   visitor: TawkVisitor(

              //     name: "Ali",
              //     email: "test@mail.com"
              //   ),
              //   onLoad: () {
              //     print('Hello Tawk!');
              //   },
              //   onLinkTap: (String url) {
              //     print(url);
              //   },
              //   placeholder: Center(
              //     child: Text('Loading...'),
              //   ),
              // ),
              body:
                  // !Get.find<AuthController>().isLoggedIn()
                  //     ?
                  WebView(
            initialUrl:
                'https://tawk.to/chat/62cbd4a47b967b117998f381/1g7m3d9qh',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) async {
              _controller = webViewController;

              //I've left out some of the code needed for a webview to work here, fyi
            },
          )
              // : NotLoggedInScreen(),
              ),
        ),
      );
    });
  }
}
