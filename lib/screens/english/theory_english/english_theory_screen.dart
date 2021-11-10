import 'dart:io';
import 'dart:math';

import 'package:english_quiz/bloc/Theory_english/theory_english_bloc.dart';
import 'package:english_quiz/screens/detail_pdf/pdf_screen.dart';
import 'package:english_quiz/widgets/bloc/widget_bloc_theory_english.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';

class EnglishTheoryScreen extends StatefulWidget {
  @override

  _EnglishTheoryScreenState createState() => _EnglishTheoryScreenState();
}

class _EnglishTheoryScreenState extends State<EnglishTheoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Container(
          padding: EdgeInsets.all(10),
          child: WidgetBackButton(),
        ),
        centerTitle: true,
        title: Text(MESSAGES.NAME, style: AppStyle.DEFAULT_MEDIUM.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            // Stack(
            //   children: [
            //     Container(
            //       height: 100,width: MediaQuery.of(context).size.width,
            //     )
            //   ],
            // ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  TheoryEnglishBloc.of(context)..add(InitTheoryEnglishEvent());
                  await Future.delayed(Duration(seconds: 2));
                },
                color: COLORS.WHITE,
                backgroundColor: COLORS.PRIMARY_COLOR,
                child: Container(
                  color: Colors.grey[200],
                  child: WidgetTheoryEnglishBloc(
                    bloc: TheoryEnglishBloc.of(context)..add(InitTheoryEnglishEvent()),
                    blocTheory: (ResponseTheoryDeatilStatus theory) {
                      final List<Theorys>? theorys = theory.data;
                      if(theorys == null){ return TrailLoading(width: 100, height: 100);}
                     else{
                        return ListView.separated(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                          itemCount: theorys.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                Platform.isIOS? _openUrl(theorys[index].content!):
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PdfScreen(theorys[index].content!),
                                    ));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),),
                                  elevation: 2,
                                  child: Container(
                                    decoration: BoxDecoration(// Set border width
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(500)), // Set rounded corner radius// Make rounded corner of border
                                    ),
                                    height: MediaQuery.of(context).size.height*0.1,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(

                                      children: [
                                        Container(
                                          height: MediaQuery.of(context).size.height,
                                          width: 10,
                                          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            // color: Colors.white,
                                              child: Image.asset(IMAGES.LOGO_APP, height: 60, width: 60,)),
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: Container(
                                            // color: Colors.white,
                                              width: MediaQuery.of(context).size.width,
                                              padding: EdgeInsets.all(22),
                                              child: Text(theorys[index].title!,maxLines: 2, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => AppValue.vSpace(12),
                        );
                      }


                    },
                  ),
                ),
              ),
            ),
          ],
        )



      ),
    );

  }
  _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }





}