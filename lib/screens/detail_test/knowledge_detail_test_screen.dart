import 'package:english_quiz/bloc/detail_question/detail_question_bloc.dart';
import 'package:english_quiz/bloc/result/result_bloc.dart';
import 'package:english_quiz/bloc/test/test_bloc.dart';
import 'package:english_quiz/screens/quiz/quiz_finished.dart';
import 'package:english_quiz/widgets/bloc/bloc.dart';
import 'package:english_quiz/widgets/quiz_options.dart';
import 'package:english_quiz/widgets/widget_appbar_new.dart';
import 'package:english_quiz/widgets/widget_count_down.dart';
import 'package:english_quiz/widgets/widget_my_radio_group.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';

const questionLeadings = ['A', 'B', 'C', 'D'];
class KnowDetailTestScreen extends StatefulWidget {
 final int id;


 KnowDetailTestScreen(this.id);

  _KnowDetailTestScreenState createState() => _KnowDetailTestScreenState();
}

class _KnowDetailTestScreenState extends State<KnowDetailTestScreen> with TickerProviderStateMixin{
  final TextStyle _questionStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black);

  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  AnimationController? _controller;
  int levelClock = 3600;

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
  @override
  void initState() {

    BlocProvider.of<DetailQuestionsBloc>(context).add(InitDetailQuestionsEvent(widget.id));
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
            levelClock)
    );

    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child:Scaffold(
        body: BlocBuilder<DetailQuestionsBloc, DetailQuestionsState>(

          builder: (context, state){
            if(state is UpdateDetailQuestionsState){
              Questions question = state.question[_currentIndex];
              final List<dynamic> options = question.incorrectAnswers!;
              if (!options.contains(question.answer)) {
                options.add(question.answer);
                options.shuffle();
                Future.delayed(Duration(seconds: 3600), () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (_) => QuizFinishedPage(
                              questions: state.question, answers: _answers)
                      )
                  );
                });
              }
              return   Scaffold(
                key: _key,
                  appBar: AppBar(
                    title: Text("Kiểm tra",style: AppStyle.DEFAULT_MEDIUM.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                    actions: [
                      Container(
                        padding: EdgeInsets.only(right: 20, top: 20),
                        child: Countdown(
                          animation: StepTween(
                            begin: levelClock, // THIS IS A USER ENTERED NUMBER
                            end: 0,
                          ).animate(_controller!),
                        ),
                      ),
                    ],
                    elevation: 0,
                  ),
                body:  SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text("${_currentIndex + 1}", style: AppStyle.DEFAULT_MEDIUM.copyWith(color: COLORS.WHITE),),
                          ),
                          SizedBox(width: 16.0),
                          state.question[_currentIndex].content!=null?
                          Expanded(
                            child:
                            state.question[_currentIndex].title.length>=5?
                            ExpandableText(
                              HtmlUnescape().convert(
                                  state.question[_currentIndex].title!)+ " " + HtmlUnescape().convert(
                                  state.question[_currentIndex].content!),
                              expandText: 'Xem thêm',
                              collapseText: 'Thu gọn',
                              maxLines: 5,
                              linkColor: Colors.blue,
                            )
                       :ExpandableText(
                              state.question[_currentIndex].content!,
                              expandText: 'Xem thêm',
                              collapseText: 'Thu gọn',
                              maxLines: 5,
                              linkColor: Colors.blue,
                            ),
                          ): Expanded(
                            child: Text(
                              HtmlUnescape().convert(
                                  state.question[_currentIndex].title!),
                              softWrap: true,
                              style: MediaQuery.of(context).size.width > 800 ? _questionStyle.copyWith(fontSize: 30.0)
                                  : _questionStyle,
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 60.0),
                      Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            ...options.map((option) => MyRadioListTile<String>(
                              title: Expanded(
                                child: Text(
                                  HtmlUnescape().convert("$option"),
                                  style: MediaQuery.of(context).size.width > 800
                                      ? TextStyle(fontSize: 30.0)
                                      : null,
                                ),
                              ),
                              leading:  '${questionLeadings[options.indexOf(option)]}',
                              groupValue: _answers[_currentIndex],
                              value: option,
                              onChanged: (value) {
                                setState(() {
                                  _answers[_currentIndex] = option;

                                });
                              },
                            )),

                          ],
                        ),
                      ),


                    ],
                  ),
                ),


                bottomNavigationBar:  Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: RaisedButton(
                          color: Colors.blue,
                          padding: MediaQuery.of(context).size.width > 800
                              ? const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 64.0)
                              : null,
                          shape:RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.blue,
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            "Quay lại",
                            style: TextStyle(fontSize: 12.0,color: Colors.white)
                            ,
                          ),
                          onPressed: (){
                            _backSubmit(state);
                          },
                        ),
                      ),

                      Container(
                        child: RaisedButton(
                          color: Colors.blue,
                          padding: MediaQuery.of(context).size.width > 800
                              ? const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 64.0)
                              : null,
                          shape:RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.blue,
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            "Menu",
                            style: TextStyle(fontSize: 12.0,color: Colors.white)
                            ,
                          ),
                          onPressed: (){
                            setState(() {
                              displayBottomSheet(context,state);
                            });

                          },
                        ),
                      ),

                      Container(
                        child: RaisedButton(
                          color: Colors.blue,
                          padding: MediaQuery.of(context).size.width > 800
                              ? const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 64.0)
                              : null,
                          shape:RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.blue,
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            _currentIndex == (state.question.length - 1)
                                ? "Nộp bài"
                                : "Tiếp",
                            style: TextStyle(fontSize: 12.0, color: Colors.white)
                            ,
                          ),
                          onPressed: (){
                            _nextSubmit(state);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

              )

              ;
            }else {
              return Center(
                child: TrailLoading(height: 100, width: 100),
              );
            }
          },
        ),
      )


    );
  }




  void displayBottomSheet(BuildContext context,UpdateDetailQuestionsState state ) {

    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Column(
            children: [
              Flexible(
                child: Padding(
                  padding:
                  const EdgeInsets.only( top: 40,bottom: 30,left: 5),
                  child: Wrap(
                      children: List.generate(state.question.length,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.only( top: 10,right: 10,left: 10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _currentIndex = index;
                                    AppNavigator.navigateBack();
                                  });
                                },
                                child:
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color:  _answers[index] != null
                                          ? Colors.blue:Colors.white,
                                      border: Border.all(
                                          width: 2,
                                          color: _currentIndex == index
                                              ? Colors.green
                                              : Colors.grey),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Text((index + 1).toString(),style: TextStyle(color:  _answers[index] != null
                                        ? Colors.white:Colors.black),),),
                                ),
                              ),
                            );
                          })),
                ),)
            ],
          );
        });
  }

  void _nextSubmit(UpdateDetailQuestionsState state) {
    if (_answers[_currentIndex] == null) {
      _key.currentState!.showSnackBar(SnackBar(
        content: Text("Bạn phải chọn đáp án trước khi chuyển tiếp câu!"),
      ));
      return;
    }
    if (_currentIndex < (state.question.length - 1)) {
      setState(() {
        _currentIndex++;
      });
    }
    else {
      showSumit(state);
    }
  }

  void _backSubmit(UpdateDetailQuestionsState state) {
    if (_currentIndex < (state.question.length - 1) && _currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }




  Future<bool> showExitPopup() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thông Báo'),
        content: Text('Bạn chắc chắn muốn bỏ bài thi ?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:Text('Không'),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child:Text('Đồng ý'),
          ),

        ],
      ),
    )??false;
  }

  Future<bool> showSumit(UpdateDetailQuestionsState state) async {
    int correct = 0;
    this._answers.forEach((index,value){
      if(state.question[index].answer == value)
        correct++;
    });
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thông Báo'),
        content: Text('Bạn chắc chắn muốn nộp bài thi ?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:Text('Không'),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => QuizFinishedPage(
                      questions: state.question, answers: _answers)));

              ResultBloc.of(context).add(InitResultEvent(widget.id,correct));
            },
            child:Text('Đồng ý'),
          ),

        ],
      ),
    )??false;
  }



}