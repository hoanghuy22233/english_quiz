import 'dart:convert';
import 'package:english_quiz/models/category.dart';
import 'package:english_quiz/models/question.dart';
import 'package:http/http.dart' as http;

// const String baseUrl = "https://opentdb.com/api.php";

Future<List<Question>> getQuestions( int total, String difficulty) async {
  // String url = "$baseUrl?amount=$total&category=9";
  // if(difficulty != null) {
  //   url = "$url&difficulty=$difficulty";
  // }
  // http.Response res = await http.get(url);
  // List<Map<String, dynamic>> questions = List<Map<String,dynamic>>.from(json.decode(res.body)["results"]);
  // return Question.fromData(questions);
  return [Question()];
}