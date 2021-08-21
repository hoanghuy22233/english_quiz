part of 'statistics_detail_bloc.dart';
abstract class StatisticsDetailState extends Equatable{
  const StatisticsDetailState();
  @override
  List<Object?> get props => [];
}

class InitStatisticsDetailState extends StatisticsDetailState{}

class UpdateStatisticsDetailState extends StatisticsDetailState{
  final PostResultData test;
  UpdateStatisticsDetailState(this.test);
  @override
  List<Object?> get props => [test];
}