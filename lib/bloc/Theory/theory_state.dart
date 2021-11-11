part of 'theory_bloc.dart';
abstract class TheoryState extends Equatable{
  const TheoryState();
  @override
  List<Object?> get props => [];
}

class UpdateTheory extends TheoryState{
  final ResponseTheoryDeatilStatus theory;
  UpdateTheory({required this.theory});
  UpdateTheory.initial() : this(theory: ResponseTheoryDeatilStatus(data: [], theory: Theorys(id: 0,type: 0,status: 0,title: '',content: '',createdAt: '',updatedAt: '')));
  @override
  List<Object> get props => [theory];
}