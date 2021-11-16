part of 'theory_container_bloc.dart';
abstract class TheoryContainerState extends Equatable{
  const TheoryContainerState();
  @override
  List<Object?> get props => [];
}

class InitTheoryContainerState extends TheoryContainerState{}

class TheoryContainerLoadingState extends TheoryContainerState{}

class UpdateTheoryContainerState extends TheoryContainerState{
  final List<Theorys> theory;
  UpdateTheoryContainerState(this.theory);
  @override
  List<Object?> get props => [theory];
}