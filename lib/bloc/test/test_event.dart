part of 'test_bloc.dart';
abstract class TestsEvent extends Equatable{
  const TestsEvent();
  @override
  List<Object?> get props => [];
}
class InitTestEvent extends TestsEvent{
  final int testId;

  InitTestEvent(this.testId);

  @override
  String toString() {
    return 'InitTestEvent{testId: $testId}';
  }

  List<Object> get props => [testId];
}

