part of 'result_bloc.dart';
abstract class ResultEvent extends Equatable{
  const ResultEvent();
  @override
  List<Object?> get props => [];
}

class InitResultEvent extends ResultEvent {
  final int type;
  final int idQ;
  InitResultEvent(this.type,this.idQ);
  @override
  String toString() {
    return 'InitDResultEvent{type: $type, idQ: $idQ}';
  }
  List<Object> get props => [type,idQ];
}