// import 'package:flutter/material.dart';
// import 'package:flutter_html_view/flutter_html_view.dart';
//
// class PostPage extends StatefulWidget {
//   final String imageUrl, title, desc;
//   PostPage({this.title, this.desc, this.imageUrl});
//
//   @override
//   _PostPageState createState() => _PostPageState();
// }
//
// class _PostPageState extends State<PostPage> {
//   Widget postContent(htmlContent) {
//     return HtmlView(
//       data: htmlContent, // optional, type String
//       onLaunchFail: (url) {
//         // optional, type Function
//         print("launch $url failed");
//       },
//       scrollable: false,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               widget.imageUrl != null
//                   ? Image.network(widget.imageUrl)
//                   : Container(),
//               SizedBox(height: 8),
//               Text(
//                 widget.title,
//                 style: TextStyle(fontSize: 18),
//               ),
//               SizedBox(height: 6),
//               postContent(
//                 widget.desc,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }