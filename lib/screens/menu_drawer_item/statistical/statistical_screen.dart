import 'dart:math';

import 'package:english_quiz/bloc/Statistics/statistics_bloc.dart';
import 'package:english_quiz/bloc/blocs.dart';
import 'package:english_quiz/bloc/test/test_bloc.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils_libs/utils_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'statistical_result_item.dart';

class StatisticalScreen extends StatefulWidget {

  StatisticalScreen({Key? key}) : super(key: key);

  @override
  _StatisticalScreenState createState() => _StatisticalScreenState();
}

class _StatisticalScreenState extends State<StatisticalScreen> {

  @override
  void initState() {
    BlocProvider.of<StatisticsBloc>(context).add(InitStatisticsEvent());
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
          title: Text(MESSAGES.STATISTICAL, style: AppStyle.DEFAULT_MEDIUM.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold)),
        ),
        body: SafeArea(
            child:  BlocBuilder<StatisticsBloc, StatisticsState>(
              builder: (context, state){
                if(state is UpdateStatisticsState){
                  var item = state.test.length;
                  return Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            StatisticsBloc.of(context)..add(InitStatisticsEvent());
                            await Future.delayed(Duration(seconds: 2));
                          },
                          color: COLORS.WHITE,
                          backgroundColor: COLORS.PRIMARY_COLOR,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BlocBuilder<InfoUserBloc, InfoUserState>(
                                bloc: InfoUserBloc.of(context)..add(InitDataEvent()),
                                builder: (context, state) {
                                  if (state is UpdateInfoUserState) {
                                    final user = state.infoUser;
                                    return  Container(
                                      height: 170,
                                      padding: EdgeInsets.all(10),
                                      color: COLORS.WHITE,
                                      child: Card(
                                        elevation: 2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(vertical: 10),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    WidgetAvatar(
                                                      height: 60,width: 60,
                                                        url: state.infoUser.image
                                                    ),
                                                    AppValue.vSpaceTiny,
                                                    Text(
                                                      MESSAGES.HELLO,
                                                      softWrap: false,
                                                      overflow: TextOverflow.fade,
                                                      style: AppStyle.DEFAULT_MEDIUM,
                                                    ),
                                                    AppValue.vSpaceTiny,
                                                    Text(
                                                      state.infoUser.name.toLowerCase(),
                                                      softWrap: false,
                                                      overflow: TextOverflow.fade,
                                                      style: AppStyle.DEFAULT_SMALLs,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: WidgetItemStatistical(title: MESSAGES.NUMBER_EXAM, number: item,))
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  else {
                                    return Center(
                                      child: TrailLoading(height: MediaQuery.of(context).size.width*0.2, width: MediaQuery.of(context).size.width*0.2),
                                    );
                                  }
                                },
                              ),

                              AppValue.vSpaceSmall,
                              Expanded(child: ListView.separated(
                                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                                itemCount: state.test.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: (){

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => StatisticalResultItem(id:state.test[index].id),
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
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }else {
                  return Center(
                    child: TrailLoading(height: MediaQuery.of(context).size.width*0.2, width: MediaQuery.of(context).size.width*0.2),
                  );
                }
              },
            )



        )
    );
  }
}


class WidgetItemStatistical extends StatelessWidget {
  final int number;
  final String title;

  const WidgetItemStatistical(
      {Key? key, required this.number, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      height: 45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: AppStyle.DEFAULT_SMALLs_BOLD,),
          AppValue.vSpaceTiny,
          Text(number.toString(), style: AppStyle.DEFAULT_SMALLs,),
        ],
      ),
    );
  }
}

class WidgetItemChart extends StatelessWidget {
  final int numberQuestion;
  final Color color;
  final String content;

  const WidgetItemChart(
      {Key? key, required this.numberQuestion, required this.color, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      height: 45,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 3,
            color: color,
          ),
          AppValue.hSpaceTiny,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(numberQuestion.toString(), style: AppStyle.DEFAULT_SMALLs_BOLD,),
              AppValue.vSpaceTiny,
              Text(content, style: AppStyle.DEFAULT_SMALLs,),
            ],
          )
        ],
      ),
    );
  }
}

class WidgetItemResult extends StatelessWidget {
  final String nameExam;
  final GestureTapCallback onTap;

  const WidgetItemResult(
      {Key? key, required this.onTap, required this.nameExam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: GestureDetector(
              onTap: onTap,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 2,
                child: Container(
                  // color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(22),
                    child: Text(nameExam, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
              ),
            ),
          )

        ],
      ),
    );
  }
}