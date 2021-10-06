import 'dart:io';
import 'package:english_quiz/controller/error.dart';
import 'package:english_quiz/models/category.dart';
import 'package:english_quiz/models/question.dart';
import 'package:english_quiz/resources/api_provider.dart';
import 'package:flutter/material.dart';

class QuizOptionsDialog extends StatefulWidget {


  @override
  _QuizOptionsDialogState createState() => _QuizOptionsDialogState();
}

class _QuizOptionsDialogState extends State<QuizOptionsDialog> {
  int? _noOfQuestions;
  String? _difficulty;
  bool processing = false;

  @override
  void initState() { 
    super.initState();
    _noOfQuestions = 30;
    _difficulty = "easy";
    processing = false;
  }

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey.shade200,
              child: Text("Chủ đề", style: Theme.of(context).textTheme.title!.copyWith(),),
            ),
            SizedBox(height: 10.0),
            Text("Chọn số câu hỏi"),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                runSpacing: 16.0,
                spacing: 16.0,
                children: <Widget>[
                  SizedBox(width: 0.0),
                  // ActionChip(
                  //   label: Text("10"),
                  //   labelStyle: TextStyle(color: Colors.white),
                  //   backgroundColor: _noOfQuestions == 10 ? Colors.indigo : Colors.grey.shade600,
                  //   onPressed: () => _selectNumberOfQuestions(10),
                  // ),
                  // ActionChip(
                  //   label: Text("20"),
                  //   labelStyle: TextStyle(color: Colors.white),
                  //   backgroundColor: _noOfQuestions == 20 ? Colors.indigo : Colors.grey.shade600,
                  //   onPressed: () => _selectNumberOfQuestions(20),
                  // ),
                  ActionChip(
                    label: Text("30"),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: _noOfQuestions == 30 ? Colors.blue : Colors.grey.shade600,
                    onPressed: () => _selectNumberOfQuestions(30),
                  ),
                  // ActionChip(
                  //   label: Text("40"),
                  //   labelStyle: TextStyle(color: Colors.white),
                  //   backgroundColor: _noOfQuestions == 40 ? Colors.indigo : Colors.grey.shade600,
                  //   onPressed: () => _selectNumberOfQuestions(40),
                  // ),
                  // ActionChip(
                  //   label: Text("50"),
                  //   labelStyle: TextStyle(color: Colors.white),
                  //   backgroundColor: _noOfQuestions == 50 ? Colors.indigo : Colors.grey.shade600,
                  //   onPressed: () => _selectNumberOfQuestions(50),
                  // ),
                  
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text("Chọn cấp độ"),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                runSpacing: 16.0,
                spacing: 16.0,
                children: <Widget>[
                  SizedBox(width: 0.0),
                  ActionChip(
                    label: Text("Dễ"),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: _difficulty == "easy" ? Colors.blue : Colors.grey.shade600,
                    onPressed: () => _selectDifficulty("easy"),
                  ),
                  ActionChip(
                    label: Text("Trung bình"),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: _difficulty == "medium" ? Colors.blue : Colors.grey.shade600,
                    onPressed: () => _selectDifficulty("medium"),
                  ),
                  ActionChip(
                    label: Text("Khó"),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: _difficulty == "hard" ? Colors.blue : Colors.grey.shade600,
                    onPressed: () => _selectDifficulty("hard"),
                  ),
                  
                ],
              ),
            ),
            SizedBox(height: 20.0),
            processing ? CircularProgressIndicator() :
            RaisedButton(
              shape:RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.blue,
                      width: 2
                  ),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Text("Bắt đầu", style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: _startQuiz,
            ),
            SizedBox(height: 20.0),
          ],
        ),
      );
  }

  _selectNumberOfQuestions(int i) {
    setState(() {
      _noOfQuestions = i;
    });
  }

  _selectDifficulty(String s) {
    setState(() {
      _difficulty=s;
    });
  }

  void _startQuiz() async {
    setState(() {
      processing=true;
    });
    try {
      List<Question> questions =  await getQuestions( _noOfQuestions!, _difficulty!);
      Navigator.pop(context);
      if(questions.length < 1) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ErrorPage(message: "There are not enough questions in the category, with the options you selected.",)
        ));
        return;
      }
      // Navigator.push(context, MaterialPageRoute(
      //   builder: (_) => QuizPage(questions: questions,)
      // ));
    }on SocketException catch (_) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => ErrorPage(message: "Can't reach the servers, \n Please check your internet connection.",)
      ));
    } catch(e){

      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => ErrorPage(message: "Unexpected error trying to connect to the API",)
      ));
    }
    setState(() {
      processing=false;
    });
  }
}