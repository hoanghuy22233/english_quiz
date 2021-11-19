part of 'theory_bloc.dart';
abstract class TheoryState extends Equatable{
  const TheoryState();
  @override
  List<Object?> get props => [];
}

class UpdateTheory extends TheoryState{
  final ResponseTheoryDeatilStatus theory;
  UpdateTheory({required this.theory});
  UpdateTheory.initial() : this(theory: ResponseTheoryDeatilStatus(data: [], theory: Theorys()));
  @override
  List<Object> get props => [theory];
}