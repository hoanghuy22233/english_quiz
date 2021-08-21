part of 'statistics_bloc.dart';
abstract class StatisticsState extends Equatable{
  const StatisticsState();
  @override
  List<Object?> get props => [];
}

class InitStatisticsState extends StatisticsState{}

class UpdateStatisticsState extends StatisticsState{
  final List<StatisticsData> test;
  UpdateStatisticsState(this.test);
  @override
  List<Object?> get props => [test];
}