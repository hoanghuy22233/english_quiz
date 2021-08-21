part of 'result_bloc.dart';
abstract class ResultState extends Equatable{
  const ResultState();
  @override
  List<Object?> get props => [];
}

class InitResultState extends ResultState{}

class UpdateResultState extends ResultState{
  final PostResultData postResultData;
  UpdateResultState(this.postResultData);
  @override
  List<Object?> get props => [postResultData];
}
