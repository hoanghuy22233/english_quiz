import 'package:english_quiz/bloc/Theory_english/theory_english_bloc.dart';
import 'package:english_quiz/widgets/bloc/widget_bloc_theory_english.dart';
import 'package:english_quiz/widgets/widgets.dart';
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
        title: Text(MESSAGES.NAME, style: AppStyle.DEFAULT_MEDIUM.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        top: true,
        child: Column(
          children: [
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
                      if(theorys == null) return TrailLoading(width: 100, height: 100);
                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                        itemCount: theorys.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: (){
                              _openUrl(theorys[index].content);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),),
                                      elevation: 2,
                                      child: Container(
                                        // color: Colors.white,
                                          child: Image.asset(IMAGES.LOGO_APP, height: 60, width: 60,)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0)),
                                      elevation: 2,
                                      child: Container(
                                        // color: Colors.white,
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(22),
                                          child: Text(theorys[index].title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                                    ),
                                  )

                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => AppValue.vSpace(12),
                      );


                    },
                  ),
                ),
              ),
            ),
          ],
        ),
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