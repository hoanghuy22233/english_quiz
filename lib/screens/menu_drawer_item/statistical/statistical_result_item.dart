
import 'package:english_quiz/bloc/statistics_detail/statistics_detail_bloc.dart';
import 'package:english_quiz/models/question.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';

// ignore: must_be_immutable
class StatisticalResultItem extends StatefulWidget {
  final int? id;
  StatisticalResultItem({this.id});

  @override
  _StatisticalResultItemState createState() => _StatisticalResultItemState();
}

class _StatisticalResultItemState extends State<StatisticalResultItem> {
  final questions = Get.arguments;

  List<Question> listQuestions = [];

  @override
  void initState() {
    BlocProvider.of<StatisticsDetailBloc>(context).add(InitStatisticsDetailEvent(widget.id!));
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    final TextStyle titleStyle = TextStyle(
      color: Colors.blue,
      fontSize: 16.0,
      fontWeight: FontWeight.w500
    );
    final TextStyle trailingStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 20.0,
      fontWeight: FontWeight.bold
    );

    return Scaffold(
        appBar: AppBar(
          leading: Container(
            padding: EdgeInsets.all(10),
            child: WidgetBackButton(),
          ),
          title: Text('Kết quả',style: AppStyle.DEFAULT_MEDIUM.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold)),
          elevation: 0,
        ),
      body: BlocBuilder<StatisticsDetailBloc, StatisticsDetailState>(
        builder: (context, state){
          if(state is UpdateStatisticsDetailState){
            return    Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        // ignore: deprecated_member_use
                        Theme.of(context).accentColor
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                  )
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        title: Text("Tổng số câu hỏi", style: titleStyle),
                        trailing: Text(state.test.total.toString(), style: trailingStyle),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        title: Text("Kết quả", style: titleStyle),
                        trailing: Text((state.test.percent).toString(), style: trailingStyle),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        title: Text("Số câu chính xác", style: titleStyle),
                        trailing: Text(state.test.totalCorrect, style: trailingStyle),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        title: Text("Số câu sai", style: titleStyle),
                        trailing: Text(state.test.totalWrong, style: trailingStyle),
                      ),
                    ),
                    AppValue.vSpaceSmall,
                  ],
                ),
              ),
            );
          }else {
            return Center(
              child: TrailLoading(height: MediaQuery.of(context).size.width*0.2, width: MediaQuery.of(context).size.width*0.2),
            );
          }
        },
      )


    );
  }
}