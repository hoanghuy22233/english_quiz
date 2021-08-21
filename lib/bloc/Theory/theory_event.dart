part of 'theory_bloc.dart';
abstract class TheoryEvent extends Equatable {
  const TheoryEvent();
  @override
  List<Object> get props => [];
}
class InitTheoryEvent extends TheoryEvent {}

class InitDetailTheoryEvent extends TheoryEvent {
  final int theoryId;
  InitDetailTheoryEvent(this.theoryId);
  @override
  String toString() {
    return 'InitDetailTheoryEvent{theoryId: $theoryId}';
  }
  List<Object> get props => [theoryId];
}

