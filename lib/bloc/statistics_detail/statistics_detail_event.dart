part of 'statistics_detail_bloc.dart';
abstract class StatisticsDetailEvent extends Equatable{
  const StatisticsDetailEvent();
  @override
  List<Object?> get props => [];
}
class InitStatisticsDetailEvent extends StatisticsDetailEvent{
  final int id;

  InitStatisticsDetailEvent(this.id);

  @override
  String toString() {
    return 'InitStatisticsDetailEvent{testId: $id}';
  }

  List<Object> get props => [id];
}

