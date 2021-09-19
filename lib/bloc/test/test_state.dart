part of 'test_bloc.dart';
abstract class TestsState extends Equatable{
  const TestsState();
  @override
  List<Object?> get props => [];
}

class InitTestState extends TestsState{}

class TestLoadingState extends TestsState{}

class UpdateTestState extends TestsState{
  final List<Tests> test;
  UpdateTestState(this.test);
  @override
  List<Object?> get props => [test];
}