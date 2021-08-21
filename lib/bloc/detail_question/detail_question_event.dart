part of 'detail_question_bloc.dart';
abstract class DetailQuestionsEvent extends Equatable{
  const DetailQuestionsEvent();
  @override
  List<Object?> get props => [];
}
class InitDetailQuestionsEvent extends DetailQuestionsEvent{
  final int id;

  InitDetailQuestionsEvent(this.id);

  @override
  String toString() {
    return 'InitDetailQuestionsEvent{testId: $id}';
  }

  List<Object> get props => [id];
}

