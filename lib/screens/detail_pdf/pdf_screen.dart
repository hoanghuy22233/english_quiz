import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';


class PdfScreen extends StatefulWidget {
  final String content;

  PdfScreen(this.content);

  @override

  _PdfScreenState createState() => _PdfScreenState(content);
}

class _PdfScreenState extends State<PdfScreen> {
  String content;
  _PdfScreenState(this.content);
  String get = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    createFileOfPdfUrl().then((f) {
      setState(() {
        get = f.path;
      });
    });
  }
  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      final filename = content.substring(content.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(content));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Container(
          padding: EdgeInsets.all(10),
          child: WidgetBackButton(

          ),
        ),
        centerTitle: true,
        title: Text(MESSAGES.THEORY, style: AppStyle.DEFAULT_MEDIUM.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold)),
      ),
      body:   get !=""?
           PDFView(
        filePath: get,
             enableSwipe: true,
             autoSpacing: true,
             pageFling: false,
             pageSnap: true,
             fitPolicy: FitPolicy.HEIGHT,
             // preventLinkNavigation:
             // false, // if set
      )
          : Center(
        child: TrailLoading(height: MediaQuery.of(context).size.width*0.2, width: MediaQuery.of(context).size.width*0.2),
      ),

    );

  }





}


