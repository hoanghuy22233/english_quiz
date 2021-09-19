part of 'theory_english_bloc.dart';
abstract class TheoryEnglishState extends Equatable{
  const TheoryEnglishState();
  @override
  List<Object?> get props => [];
}
class TheoryEnglishLoadingState extends TheoryEnglishState {}

class UpdateTheoryEnglish extends TheoryEnglishState{
  final ResponseTheoryDeatilStatus theory;
  UpdateTheoryEnglish({required this.theory});
  UpdateTheoryEnglish.initial() : this(theory: ResponseTheoryDeatilStatus(data: [], theory: Theorys()));
  @override
  List<Object> get props => [theory];
}