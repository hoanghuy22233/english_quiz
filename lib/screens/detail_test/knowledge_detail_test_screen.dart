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

const questionLeading = ['Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D'];
const questionLeadings = ['A', 'B', 'C', 'D'];
class KnowDetailTestScreen extends StatefulWidget {
 final int id;
 final Tests test;


 KnowDetailTestScreen(this.id,this.test);

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
              return Scaffold(
                key: _key,
                appBar: AppBar(
                  title: Text("Kiểm tra",
                      style: AppStyle.DEFAULT_MEDIUM.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  centerTitle: true,
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Container(
                    //  padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)
                              //                 <--- border radius here
                            ),),
                          width: MediaQuery.of(context).size.width,
                          // height: 100,
                          padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),

                          child: Row(
                            children: [
                              Expanded(
                                  flex: 7,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.test.title!.length <= 25
                                              ? widget.test.title!
                                              : widget.test.title!
                                              .substring(0, 25) +
                                              '...',style:AppStyle.DEFAULT_MEDIUM.copyWith(
                                            color: Colors.white),maxLines: 2,

                                        ),
                                        SizedBox(height: 10,),

                                        Text("${state.question.length}" + " câu", style: AppStyle.DEFAULT_MEDIUM.copyWith(color: COLORS.ORANGE).copyWith(fontWeight: FontWeight.bold),),


                                      ],
                                    ),
                                  )),
                              Expanded(
                                flex: 3,
                                child:Card(
                                  elevation: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: COLORS.WHITE,
                                        borderRadius: BorderRadius.circular(30)),

                                    child: Countdown(
                                      animation: StepTween(
                                        begin: levelClock, // THIS IS A USER ENTERED NUMBER
                                        end: 0,
                                      ).animate(_controller!),
                                    ),
                                  ),
                                ),),
                            ],
                          ),

                        ),
                        SizedBox(height: 10,),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Câu hỏi "+"${_currentIndex + 1}", style: AppStyle.DEFAULT_MEDIUM.copyWith(color: COLORS.BLACK,fontWeight: FontWeight.bold)),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  state.question[_currentIndex].content!=null?
                                  Expanded(
                                    child:
                                    state.question[_currentIndex].title!.length>=5?
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
                              SizedBox(height: 10,),

                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[

                              ...options.map((option) =>

                                  MyRadioListTile<String>(
                                  //  questions: '${questionLeading[options.indexOf(option)]}',
                                    title: Expanded(
                                      child: Text(
                                        HtmlUnescape().convert("$option"),
                                        style: MediaQuery.of(context)
                                            .size
                                            .width >
                                            800
                                            ? TextStyle(fontSize: 16.0)
                                            : null,
                                      ),
                                    ),
                                    leading: '${questionLeadings[options.indexOf(option)]}',
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
                ),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/3.1,
                        height: MediaQuery.of(context).size.width*0.15,
                        child: RaisedButton(
                          color: Colors.blue,
                          padding: MediaQuery.of(context).size.width > 800
                              ? const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 64.0)
                              : null,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue, width: 2),
                            // borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            "Quay lại",
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            _backSubmit(state);
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/3.1,
                        height: MediaQuery.of(context).size.width*0.15,
                        child: RaisedButton(
                          color: Colors.blue,
                          padding: MediaQuery.of(context).size.width > 800
                              ? const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 64.0)
                              : null,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue, width: 2),
                            // borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            "Menu",
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            setState(() {
                              displayBottomSheet(context, state);
                            });
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/3.1,
                        height: MediaQuery.of(context).size.width*0.15,
                        child: RaisedButton(
                          color: Colors.blue,
                          padding: MediaQuery.of(context).size.width > 800
                              ? const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 64.0)
                              : null,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue, width: 2),
                            // borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            _currentIndex == (state.question.length - 1)
                                ? "Nộp bài"
                                : "Tiếp",
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
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




  void displayBottomSheet(
      BuildContext context, UpdateDetailQuestionsState state) {
    showModalBottomSheet(
        isScrollControlled: true,

        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(20)
            )
        ),
        builder: (ctx) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 20,bottom: 10),
                child: Text("Menu", style: AppStyle.DEFAULT_MEDIUM_BOLD,),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.grey[300],
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 30, left: 5),
                  child: Wrap(
                      children: List.generate(state.question.length, (index) {
                        return Padding(
                          padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _currentIndex = index;
                                AppNavigator.navigateBack();
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width/7,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: _answers[index] != null
                                      ? Colors.blue
                                      : Colors.blue[50],
                                  border: Border.all(
                                      width: 2,
                                      color: _currentIndex == index
                                          ? Colors.blue
                                          : Color(0xFFE3F2FD) ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                      color: _answers[index] != null
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
                ),
              )
            ],
          );
        });
  }

  void _nextSubmit(UpdateDetailQuestionsState state) {
    if (_currentIndex < (state.question.length - 1)) {
      setState(() {
        _currentIndex++;
      });
    } else {
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