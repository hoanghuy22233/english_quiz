// ignore: import_of_legacy_library_into_null_safe
import 'package:english_quiz/bloc/Theory/theory_bloc.dart';
import 'package:utils_libs/utils_libs.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_quiz/api_resfull/api.dart';
part 'theory_container_event.dart';
part 'theory_container_state.dart';
class TheoryContainerBloc extends Bloc<TheoryContainerEvent, TheoryContainerState>{
  UserRepository _userRepository;
  TheoryContainerBloc({required UserRepository userRepository}) : _userRepository = userRepository, super(InitTheoryContainerState());
  @override
  Stream<TheoryContainerState> mapEventToState(TheoryContainerEvent event) async* {
    if(event is InitTheoryContaineEvent){
      yield* _mapTheoryContainerEventToState(event.theoryId);
    }
  }
  Stream<TheoryContainerState> _mapTheoryContainerEventToState(int theoryId) async* {
    yield TheoryContainerLoadingState();
    try{
      final response = await _userRepository.getTheory(type: theoryId);
      // ignore: unrelated_type_equality_checks
      if(response.status == BASE_URL.SUCCESS){
        yield UpdateTheoryContainerState(List<Theorys>.from(response.data));
      }
    }catch(e){
      throw e;
    }
  }
  static TheoryContainerBloc of(BuildContext context) => BlocProvider.of<TheoryContainerBloc>(context);
}