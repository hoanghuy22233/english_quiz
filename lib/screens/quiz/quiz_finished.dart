import 'package:english_quiz/controller/check_answers.dart';
import 'package:english_quiz/models/question.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:utils_libs/utils_libs.dart';

class QuizFinishedPage extends StatelessWidget {
  final List<Questions>? questions;
  final Map<int, dynamic>? answers;
  
  int? correctAnswers;
  QuizFinishedPage({Key? key, @required this.questions, @required this.answers}): super(key: key);
  @override
  Widget build(BuildContext context){
    int correct = 0;
    this.answers!.forEach((index,value){
      if(this.questions![index].answer == value)
        correct++;
    });
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
          child: WidgetBackButton(
            onTap:() => AppNavigator.navigateMain(),
          ),
        ),
        centerTitle: true,
        title: Text('Kết quả',style: AppStyle.DEFAULT_MEDIUM.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
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
                  trailing: Text("${questions!.length}", style: trailingStyle),
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
                  trailing: Text((correct/questions!.length * 100).toStringAsFixed(2).toString() + "%", style: trailingStyle),
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
                  trailing: Text("$correct/${questions!.length}", style: trailingStyle),
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
                  trailing: Text("${questions!.length - correct}/${questions!.length}", style: trailingStyle),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    child: Text("Về trang chủ",style: TextStyle(color: Colors.blue)),
                    onPressed: ()  => AppNavigator.navigateMain(),
                  ),
                  RaisedButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    child: Text(MESSAGES.REVIEW_EXAM, style: TextStyle(color: Colors.blue),),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CheckAnswersPage(questions: questions, answers: answers,)
                      ));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}