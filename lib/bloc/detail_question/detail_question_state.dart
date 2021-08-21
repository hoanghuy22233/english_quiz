part of 'detail_question_bloc.dart';
abstract class DetailQuestionsState extends Equatable{
  const DetailQuestionsState();
  @override
  List<Object?> get props => [];
}

class InitDetailQuestionsState extends DetailQuestionsState{}

class UpdateDetailQuestionsState extends DetailQuestionsState{
  final List<Questions> question;
  UpdateDetailQuestionsState(this.question);
  @override
  List<Object?> get props => [question];
}