import 'package:flutter/material.dart';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class UserGuilderScreen extends StatefulWidget {
  @override
  _UserGuilderScreenState createState() => _UserGuilderScreenState();
}

class _UserGuilderScreenState extends State<UserGuilderScreen> {
  bool _isLoading = true;
  // PDFDocument? document;

  @override
  void initState() {
    super.initState();
    // loadDocument();
  }

  // loadDocument() async {
  //   // document = await PDFDocument.fromAsset('assets/file/huong_dan.pdf');
  //   document = await PDFDocument.fromURL(
  //     "https://hcdc.vn/public/img/da39a3ee5e6b4b0d3255bfef95601890afd80709/images/dangbai1/images/tp-hcm-trien-khai-cham-soc-va-theo-doi-suc-khoe-doi-voi-f0-tai-nha/files/Info%20Huong%20dan%20F0%20tai%20nha.pdf",
  //     cacheManager: CacheManager(
  //       Config(
  //         "customCacheKey",
  //         stalePeriod: const Duration(days: 2),
  //         maxNrOfCacheObjects: 10,
  //       ),
  //     ),
  //   );

  //   setState(() => _isLoading = false);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Trang Chủ"),
          backgroundColor: Color.fromRGBO(78, 159, 193, 1),
        ),
        body: Center(child: Center(child: CircularProgressIndicator())
            // : PDFViewer(
            //     document: document!,
            //     zoomSteps: 2,
            //     //uncomment below line to preload all pages
            //     // lazyLoad: false,
            //     // uncomment below line to scroll vertically
            //     // scrollDirection: Axis.vertical,

            //     //uncomment below code to replace bottom navigation with your own
            //     /* navigationBuilder:
            //         (context, page, totalPages, jumpToPage, animateToPage) {
            //       return ButtonBar(
            //         alignment: MainAxisAlignment.spaceEvenly,
            //         children: <Widget>[
            //           IconButton(
            //             icon: Icon(Icons.first_page),
            //             onPressed: () {
            //               jumpToPage()(page: 0);
            //             },
            //           ),
            //           IconButton(
            //             icon: Icon(Icons.arrow_back),
            //             onPressed: () {
            //               animateToPage(page: page - 2);
            //             },
            //           ),
            //           IconButton(
            //             icon: Icon(Icons.arrow_forward),
            //             onPressed: () {
            //               animateToPage(page: page);
            //             },
            //           ),
            //           IconButton(
            //             icon: Icon(Icons.last_page),
            //             onPressed: () {
            //               jumpToPage(page: totalPages - 1);
            //             },
            //           ),
            //         ],
            //       );
            //     }, */
            //   ),
            ),
      ),
    );
  }
}
