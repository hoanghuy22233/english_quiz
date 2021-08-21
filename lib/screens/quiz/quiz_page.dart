import 'package:english_quiz/models/category.dart';
import 'package:english_quiz/models/question.dart';
import 'package:english_quiz/screens/quiz/quiz_finished.dart';
import 'package:english_quiz/widgets/widget_count_down.dart';
import 'package:english_quiz/widgets/widget_my_radio_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:utils_libs/utils_libs.dart';

class QuizPage extends StatefulWidget {
  final List<Question>? questions;

  const QuizPage({Key? key, @required this.questions,})
      : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin{
  final TextStyle _questionStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);


  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  AnimationController? _controller;
  int levelClock = 1800;

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
            levelClock)
    );

    _controller!.forward().whenComplete(nextQuestion);
  }

  void nextQuestion() {
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //     builder: (_) => QuizFinishedPage(
    //         questions: widget.questions, answers: _answers)));
  }
  final item = ['A', 'B', 'C', 'D',];

  int i=0;



  void displayBottomSheet(BuildContext context) {
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
                      children: List.generate(widget.questions!.length,
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
  @override
  Widget build(BuildContext context) {
    Question question = widget.questions![_currentIndex];
    final List<dynamic> options = question.incorrectAnswers!;
    if (!options.contains(question.correctAnswer)) {
      options.add(question.correctAnswer);
      options.shuffle();
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text("Kiểm tra aa"),
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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      child: Text("${_currentIndex + 1}", style: AppStyle.DEFAULT_SMALL.copyWith(color: COLORS.BLACK),),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        HtmlUnescape().convert(
                            widget.questions![_currentIndex].question!),
                        softWrap: true,
                        style: MediaQuery.of(context).size.width > 800
                            ? _questionStyle.copyWith(fontSize: 30.0)
                            : _questionStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60.0),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      ...options.map((option) => MyRadioListTile<String>(
                        title: Text(
                          HtmlUnescape().convert("$option"),
                          style: MediaQuery.of(context).size.width > 800
                              ? TextStyle(fontSize: 30.0)
                              : null,
                        ),
                        leading: '${option[0]}',
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
                  onPressed: _backSubmit,
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
                      displayBottomSheet(context);
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
                    _currentIndex == (widget.questions!.length - 1)
                        ? "Nộp bài"
                        : "Tiếp",
                    style: TextStyle(fontSize: 12.0, color: Colors.white)
                    ,
                  ),
                  onPressed: _nextSubmit,
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }

  void _nextSubmit() {
    if (_answers[_currentIndex] == null) {
      _key.currentState!.showSnackBar(SnackBar(
        content: Text("Bạn phải chọn đáp án trước khi chuyển tiếp câu!"),
      ));
      return;
    }
    if (_currentIndex < (widget.questions!.length - 1)) {
      setState(() {
        _currentIndex++;
      });
    } else {
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //     builder: (_) => QuizFinishedPage(
      //         questions: widget.questions, answers: _answers)));
    }
  }

  void _backSubmit() {
    if (_currentIndex < (widget.questions!.length - 1) && _currentIndex > 0) {
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


}



