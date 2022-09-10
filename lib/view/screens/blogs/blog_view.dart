import 'dart:convert';

import 'package:efood_multivendor/view/screens/blogs/post_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BlogView extends StatefulWidget {
  @override
  _BlogViewState createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  Future<List> fetchWpPosts() async {
    final response = await http.get(
        Uri.parse("https://blog.bigmeatmart.com/wp-json/wp/v2/posts?categories=4"),
        headers: {"Accept": "application/json"});

    var convertDatatoJson = jsonDecode(response.body);
    return convertDatatoJson;
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Big Meat Mart"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 24),
        child: FutureBuilder(
          future: fetchWpPosts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map wppost = snapshot.data[index];

                    return wppost == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : InkWell(
                            onTap: () {
                              Get.to(() => PostDetailsView(
                                    image: wppost['_links']["wp:attachment"][0]
                                        ["href"],
                                    title: wppost['title']['rendered']
                                        .replaceAll("#038;", ""),
                                    description: wppost['content']['rendered'],
                                  ));
                            },
                            child: PostTile(
                                imageApiUrl: wppost['_links']["wp:attachment"]
                                    [0]["href"],
                                excerpt: "",
                                desc: wppost['content']['rendered'],
                                title: wppost['title']['rendered']
                                    .replaceAll("#038;", "")),
                          );
                  });
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class PostTile extends StatefulWidget {
  final String imageApiUrl, title, desc, excerpt;

  PostTile({this.imageApiUrl, this.title, this.desc, this.excerpt});

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
              future: fetchWpPostImageUrl(widget.imageApiUrl),
              builder: (context, snapshot) {
                if (snapshot.hasData)     if (snapshot.data.isNotEmpty)  {
                  print(snapshot.data);
                  imageUrl = snapshot.data[0]["guid"]["rendered"];
                  print(imageUrl);
                  return Image.network(imageUrl);
                }
                return Center(child: Container());
              }),
          SizedBox(height: 8),
          Text(
            widget.title,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(widget.excerpt)
        ],
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
