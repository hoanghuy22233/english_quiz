import 'package:english_quiz/models/question.dart';
import 'package:english_quiz/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:utils_libs/utils_libs.dart';

class CheckAnswersPage extends StatelessWidget {
  final List<Questions>? questions;
  final Map<int,dynamic>? answers;

  const CheckAnswersPage({Key? key, @required this.questions, @required this.answers}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.all(10),
          child: WidgetBackButton(
          ),
        ),
        title: Text('Kiểm tra lại',style: AppStyle.DEFAULT_MEDIUM.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
              ),
              height: 200,
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: questions!.length+1,
            itemBuilder: _buildItem,

          )
        ],
      ),
    );
  }
  Widget _buildItem(BuildContext context, int index) {
    if(index == questions!.length) {
      return RaisedButton(
        child: Text("Quay lại", style: TextStyle(color:Colors.white,),),
        shape:RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.blue,
                width: 2
            ),
            borderRadius: BorderRadius.circular(20)
        ),
        color: Colors.blue,
        onPressed: (){
        AppNavigator.navigateBack();
        },
      );
    }
    Questions question = questions![index];
    bool correct = question.answer == answers![index];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${index+1}. ' + HtmlUnescape().convert(question.title!), style: AppStyle.DEFAULT_MEDIUM.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500),),
            SizedBox(height: 5.0),
            Text(HtmlUnescape().convert("${answers![index]}"), style: AppStyle.DEFAULT_MEDIUM_BOLD.copyWith(
              color: correct ? Colors.green : Colors.red,
              fontSize: 18.0,
            ),),
            SizedBox(height: 5.0),
            correct ? Container(): Text.rich(TextSpan(
              children: [
                TextSpan(text: "Đáp án: "),
                TextSpan(text: HtmlUnescape().convert(question.answer!) , style: AppStyle.DEFAULT_MEDIUM)
              ]
            ),style: AppStyle.DEFAULT_MEDIUM,)
          ],
        ),
      ),
    );
  }
}