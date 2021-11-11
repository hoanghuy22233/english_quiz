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


  Future<bool> showSumit(BuildContext context,int index) async {

    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Giải thích câu'),
        content: questions![index].note!=null?Text(questions![index].note,style: TextStyle(color: Colors.black,fontSize: 12)):Text("Chưa có giải thích",style: TextStyle(color: Colors.black,fontSize: 12),),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:Text('Thoát'),
          ),


        ],
      ),
    )??false;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.all(10),
          child: WidgetBackButton(
          ),
        ),
        centerTitle: true,
        title: Text('Kiểm tra lại',style: AppStyle.DEFAULT_MEDIUM.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width*0.1,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                //                 <--- border radius here
              ),
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
            Text('${index+1}. ' + HtmlUnescape().convert(question.title), style: AppStyle.DEFAULT_MEDIUM.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500),),
            SizedBox(height: 5.0),
            answers![index]!=null?
            Text(HtmlUnescape().convert("${answers![index]}"), style: AppStyle.DEFAULT_MEDIUM_BOLD.copyWith(
              color: correct ? Colors.green : Colors.red,
              fontSize: 18.0,
            ),):Text("Chưa trả lời",style: AppStyle.DEFAULT_MEDIUM_BOLD,),
            SizedBox(height: 5.0),
            correct ? Container(): Text.rich(TextSpan(
              children: [
                TextSpan(text: "Đáp án: "),
                TextSpan(text: HtmlUnescape().convert(question.answer) , style: AppStyle.DEFAULT_MEDIUM)
              ]
            ),style: AppStyle.DEFAULT_MEDIUM,),
            SizedBox(height: 5.0),
            Container(
              color: Colors.grey[300],
              width: MediaQuery.of(context).size.width,
            height: 1,),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: (){
                showSumit(context,index);
              },
              child: Text("Xem giải thích", style: TextStyle(color: Colors.green, fontSize: 14,decoration: TextDecoration.underline,),),
            )
          ],
        ),
      ),
    );
  }


}