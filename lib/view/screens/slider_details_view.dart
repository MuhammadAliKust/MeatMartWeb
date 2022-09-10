import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
class SliderDetailsView extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  SliderDetailsView({this.image, this.title, this.description});
  fetchWpPostImageUrl(url) async {
    final response =
    await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    var convertDatatoJson = jsonDecode(response.body);
    // print("Good : $convertDatatoJson");
    return convertDatatoJson;
  }

  String imageUrl = "";
  @override
  Widget build(BuildContext context) {
    print(description);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(""),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: fetchWpPostImageUrl(image),
                builder: (context, snapshot) {
                  if (snapshot.data.isNotEmpty) if (snapshot.hasData) {
                    print(snapshot.data);
                    imageUrl = snapshot.data[0]["guid"]["rendered"];
                    print(imageUrl);
                    return Image.network(imageUrl);
                  }
                  return Center(child: Container());
                }),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child:  Html(
                  data: """<div>
     ${description}
        <!--You can pretty much put any html in here!-->
      </div>""",
                )
            ),
          ],
        ),
      ),
    );
  }
}
