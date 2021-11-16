part of 'theory_container_bloc.dart';
abstract class TheoryContainerEvent extends Equatable{
  const TheoryContainerEvent();
  @override
  List<Object?> get props => [];
}
class InitTheoryContaineEvent extends TheoryContainerEvent{
  final int theoryId;

  InitTheoryContaineEvent(this.theoryId);

  @override
  String toString() {
    return 'InitTheoryContaineEvent{testId: $theoryId}';
  }

  List<Object> get props => [theoryId];
}


