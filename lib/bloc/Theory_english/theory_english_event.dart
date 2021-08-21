part of 'theory_english_bloc.dart';
abstract class TheoryEnglishEvent extends Equatable {
  const TheoryEnglishEvent();
  @override
  List<Object> get props => [];
}
class InitTheoryEnglishEvent extends TheoryEnglishEvent {}

class InitDetailTheoryEnglishEvent extends TheoryEnglishEvent {
  final int theoryId;
  InitDetailTheoryEnglishEvent(this.theoryId);
  @override
  String toString() {
    return 'InitDetailTheoryEnglishEvent{theoryId: $theoryId}';
  }
  List<Object> get props => [theoryId];
}