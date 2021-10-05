import 'dart:math';

import 'package:english_quiz/bloc/test/test_bloc.dart';
import 'package:english_quiz/screens/detail_test/knowledge_detail_test_screen.dart';
import 'package:english_quiz/widgets/quiz_options.dart';
import 'package:english_quiz/widgets/widget_appbar_new.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';

class KnowledgeTestScreen extends StatefulWidget {
  @override

  _KnowledgeTestScreenState createState() => _KnowledgeTestScreenState();
}

class _KnowledgeTestScreenState extends State<KnowledgeTestScreen> {

  @override
  void initState() {
    BlocProvider.of<TestsBloc>(context).add(InitTestEvent(1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Container(
          padding: EdgeInsets.all(10),
          child: WidgetBackButton(),
        ),
        title: Text(MESSAGES.NAME,  style: AppStyle.DEFAULT_MEDIUM.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<TestsBloc, TestsState>(
          builder: (context, state){
            if(state is UpdateTestState){
              return Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        TestsBloc.of(context)..add(InitTestEvent(1));
                        await Future.delayed(Duration(seconds: 2));
                      },
                      color: COLORS.WHITE,
                      backgroundColor: COLORS.PRIMARY_COLOR,
                      child: Container(
                        color: Colors.grey[200],
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                          itemCount: state.test.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => KnowDetailTestScreen(state.test[index].id),
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
                                              child: Text(state.test[index].title,maxLines: 2, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => AppValue.vSpace(12),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }else {
              return Center(
                child: TrailLoading(height: 100, width: 100),
              );
            }
          },
        ),
      ),
    );
  }



}