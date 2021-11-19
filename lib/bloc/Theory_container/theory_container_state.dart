part of 'theory_container_bloc.dart';
abstract class TheoryContainerState extends Equatable{
  const TheoryContainerState();
  @override
  List<Object?> get props => [];
}

class UpdateContainerTheory extends TheoryContainerState{
  final ResponseTheoryDeatilStatus theorys;
  UpdateContainerTheory({required this.theorys});
  UpdateContainerTheory.initial() : this(theorys: ResponseTheoryDeatilStatus(data: [], theory: Theorys()));
  @override
  List<Object> get props => [theorys];
}